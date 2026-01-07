Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2B34404F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809705; cv=none; b=j3TsYyYBmVlAFY+Xexq9KjrQXE7l+SHiFwDF/6aVJHqxYe83g3HRrneef9jICS9L/+ShRYvUjSPJXZyVZ1fN7qNRvb/LfpbVcKe4/MrEGFAy0iFn0jSSqPQzSINKhKh3EPrkJQp4gEsWfRTb2u82eYvI6FRhekPJAl1TzTUjHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809705; c=relaxed/simple;
	bh=4vXpfTBTtosW1YkBGU2cXKm0gUZHE1XfllSb1c1clWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfi0uIGtNfs8loT08eL9LW0Z8/4dzEX6n3vLfq2J0B3jbfwF1QdMSueGEnpHfeUlKHAD7IHfSKeXhrfsDlXytBurhxw2stuKQ+3zonNuI9u9ZE/UV6l158nMrkhhqHdUf7BcxxU2KMM3ly44bLtX8QduOVd9NmiJCCCMtckGXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lN5NJtaR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lN5NJtaR"
Date: Wed, 7 Jan 2026 10:14:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767809700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6gQmrBLod72VMhYIjEsbgkDI+rMTnWyrfeFXZA05yw=;
	b=lN5NJtaRtMTo4VMFcEOZZPN4+z2UhhQnzdoOLBsH+NcWlYgHwEGPikBQuMd9TKj45W8DLp
	Ys1p7ifbN4obItJklJTP5IPlI9kc/2l0CR75daRnvPOIqjxHv40GquxxjetATZQ6j8BT5a
	lPvUjMto7oLx4kBEW0us9vKo0n2w9mE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <ovqxo2mmjiuymqk36t2xydcyzvtppcqsog62yx3qtwsknbkgzq@3phadh5gfyjd>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-2-tballasi@linux.microsoft.com>
 <62ia3v3oduyt2srkaneccoei7cwimifwduarteyn2ugpmmbw3p@rivcqvcksgpt>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ia3v3oduyt2srkaneccoei7cwimifwduarteyn2ugpmmbw3p@rivcqvcksgpt>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 05, 2026 at 02:46:39PM -0800, Shakeel Butt wrote:
[...]
> 
> Orthogonally I am cleaning up memcg id usage and after that cleanup,
> mem_cgroup_id() would be preferred way to get the ID. No need to do
> anything now as I will cleanup this usage later as well.

The series has been landed in mm-new. Please use mem_cgroup_id() instead
of cgroup_id(memcg->css.cgroup).
