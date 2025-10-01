Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A82D9488
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309893; cv=none; b=lBTQIwGActd6kW1CUVbZt7CudRSV6+OEm6ESuYyk3HDfgcPyTM1PLkVdneWPchidaXdLcc1LzEm2kU4ht9HpGW2/zvUU6qij8TEXxsCu1rg5NUiegQ9IOODfAxeQUnOmH1lQVrPU/CZvrT/8N2L0NMl+RzcGhXK2/eHInkIJlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309893; c=relaxed/simple;
	bh=lz6JwS8s1QuPr6hF0LbxkBtxrpBZy5F0WeiYsXNwOOs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uiqVXjjDPSnmx9xQOpLH37rFQFWpkv7XY+OruGNoJkZ/lUPfZws0b8mcLgn3INnonGxf3Ig4fjU/uai0VsOGat/vHMICfAMlY4KPlMNw2XN5gxtI9NlUGAXKHRGkCZUuwNT7ZHbb/zaQUHiN8yHsqYzp8P+n+fh7B4xr+9uQqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6TJ5RTE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6TJ5RTE"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759309889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lz6JwS8s1QuPr6hF0LbxkBtxrpBZy5F0WeiYsXNwOOs=;
	b=f6TJ5RTEZEjsLqm3Q5Xrw91rbTDvGOODuG0nI1pGAGx3P2laUc92BAmIlc2e5p9YUSbjK0
	ur7efzl/DYOpjBMk9pZqL8hzy6c42qhgJXxPdEIWwA1KLbMnwlGT9MjTcZ5IWpVayXbri9
	Sxw4WDAdfd5bpLZPl/8favIYrqSSAsI=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user with
 memdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250930190932.26b49afe@gandalf.local.home>
Date: Wed, 1 Oct 2025 11:11:16 +0200
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1ED366BF-BAF8-4140-B260-B2A40B5E5996@linux.dev>
References: <20250925211736.81737-1-thorsten.blum@linux.dev>
 <20250930172841.63dc86b5@gandalf.local.home>
 <76B6CC10-1C0A-42D0-83E8-8CA8A7790BF0@linux.dev>
 <20250930190932.26b49afe@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 1. Oct 2025, at 01:09, Steven Rostedt wrote:
> Thanks, you can base it off of my for-next branch.

I think your for-next branch[1] doesn't include the fix a2501032de0d
("tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()")
yet, does it? My patch would need to be applied on top of that.

Thanks,
Thorsten

[1] =
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/=
?h=3Dfor-next

