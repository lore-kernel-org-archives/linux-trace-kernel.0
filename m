Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9036607E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875264; cv=none; b=r7NL2IlpIFNq1XDETbsO42YxvkqvlUZZNiAAnnw/iyzYNDZFsDKZNs4d/vTGz95CUBC9SfMVSjmcAsgM+Se0ALYMV7y+wv07iPAuQicfeKCGI5BwfezzCLZYP55rL3K4UqZ+6gfp7AJf1BISTHX5ALKuyinzb5pO5HiWfVXNViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875264; c=relaxed/simple;
	bh=0LGa7EgxjOEshQzIs10+MaT8EhFUnttL1ZhHSjUWhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN3uT1PpEqurYiGQjIVj6oWHmHwDOmya1wryNAeHYk6iaByUicFyTRPpLAkU2zZ7mJRiD9Gayt5k/M32QAoqsxV9mUKzoNFqZaGtv2uz+8CJjRQm3cAYDlxL/gG7j4nOoIgIKYnTFsR6/yQllO+kwZsR8w+EzGtjVOfM7p+8UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Efc4suOe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Efc4suOe"
Date: Mon, 23 Feb 2026 11:34:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771875261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ankHr9tSJqIrETb5hcnz3SBlChL1ny9Cho/sWsrfPQs=;
	b=Efc4suOe0fbcjO6Ps7x6R3IBLwx907NhPrC5I3eVGAIJbQ9hUTd5vRH2+zoNcMY5fSCNe5
	AqyMkeEHd55XlQfztLlGIIiwrI8JDHQgdul1BkM3VL6JoGS1i/Hca+xcoI1nX0P9+mnFGe
	kNVvibBtIPzKJdGtwOv2UjrQIQN7Qu8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, david@kernel.org, 
	hannes@cmpxchg.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org, rostedt@goodmis.org, 
	weixugc@google.com, yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v7 2/3] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <aZyrkRDJpHh8ZnCW@linux.dev>
References: <20260213181537.54350-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-3-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223171544.4750-3-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 23, 2026 at 09:15:43AM -0800, Thomas Ballasi wrote:
> Memory reclaim events are currently difficult to attribute to
> specific cgroups, making debugging memory pressure issues
> challenging.  This patch adds memory cgroup ID (memcg_id) to key
> vmscan tracepoints to enable better correlation and analysis.
> 
> For operations not associated with a specific cgroup, the field
> is defaulted to 0.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
