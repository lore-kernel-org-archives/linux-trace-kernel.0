Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6D23A984;
	Fri, 19 Dec 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160056; cv=none; b=rjtgkZeznrp7Z3XjYOOlgwfXiJVFeheHylkMcqjDTKq5UoGW1lq3giZwin5hclpg9vPJVug6mIjurCXY6CaQ4bD5ASWyAgBC7KJ8+mkZTKCxENhZcXTTwtBmbStW6Hzc7iG8oQvFABqtAZuBITGLFpOl/AOkXR9wo6PFweBzii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160056; c=relaxed/simple;
	bh=ubmk564mZhVjNIunyhFyRVWYQUIX3tzkV8rUqSxXjHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzi9uHhrJVOh57MKGNJ+Vh+n+KnowsaOqYZKgI7Mc5OgQtKiL878OXn8nT4WN4PueDGUN+H/Xc+Hk3US+T2iuEl/GHpwlLzYhgMJG8J+1mg8anCZeX0ni1leoymwL+EdvgbiBLtSiTLPCgDp08laqykE9ZrbKc2uRsao8eeSa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovlQWGJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovlQWGJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3084BC4CEF1;
	Fri, 19 Dec 2025 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766160055;
	bh=ubmk564mZhVjNIunyhFyRVWYQUIX3tzkV8rUqSxXjHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovlQWGJWEZcPQLYelIukLOqalx/qp1OwKqd7aa3KhVjiRmJZvqijCRnc5lMxtlZCf
	 1utDGwrN3sGSzfljsYYIr5qrXweO3nQLm6baV5UVmwTIP73WDjhEmzyhhNi2UIBCrU
	 3dN63Bciu0q5BdobvfgDiw1lllFk6gPOmThsqQVo=
Date: Fri, 19 Dec 2025 11:00:54 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
Message-ID: <20251219-flying-congenial-harrier-a7e4f5@lemur>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
 <848E8F85-CD24-491C-8A3B-474E4FCBF995@nvidia.com>
 <32f3f9dd-f84c-4113-b356-01750b2af80a@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32f3f9dd-f84c-4113-b356-01750b2af80a@amd.com>

On Fri, Dec 19, 2025 at 05:50:39PM +0530, Garg, Shivank wrote:
> I noticed that b4 didn't pick up your Reviewed-by tag automatically (possibly because
> it was on the same line as "LGTM.").

That is correct -- code review trailers must always be on a separate line for
any tooling to properly recognize them.

Best regards,
-K
