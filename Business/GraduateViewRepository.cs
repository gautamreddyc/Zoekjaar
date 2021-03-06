﻿using System.Collections.Generic;
using System.Linq;
using Business.Criteria;

namespace Business
{
	public sealed class GraduateViewRepository : SearchRepositoryBase<GraduateView, SearchCriteria>
	{
		public override IEnumerable<GraduateView> Fetch(SearchCriteria criteria)
		{
			var query = this.Context.Graduates.Where(_ => true);
			if (criteria.CurrentStatusId.HasValue)
			{
				query = query.Where(_ => _.CurrentStatusId == criteria.CurrentStatusId);
			}
			if (criteria.VisaStatusId.HasValue)
			{
				query = query.Where(_ => _.VisaStatusId == criteria.VisaStatusId);
			}

			criteria.TotalRecords = query.Count();
			return query.OrderBy(_ => _.LastName)
				.ThenBy(_ => _.FirstName)
				.Skip(criteria.PageNumber * criteria.PageSize)
				.Take(criteria.PageSize).AsEnumerable().Select(_ => new GraduateView
				{
					GraduateId = _.Id,
					Name = string.Format("{0}, {1}", _.LastName, _.FirstName)
				});
		}
	}
}
