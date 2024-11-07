Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C18188A3B;
	Thu,  7 Nov 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004561; cv=none; b=FPMaOMljOrX74CfFb/lwbu3f/tpWDWIhDm/yKIETzvSnt2avqoAEIWWR6ZQXGoAB8YSgeu0HdP7SR/ZFMN4WquGuLIu7fe2Rbbt33116YX2cA8tdXfo+MBhABVUI/sHGeHXRkTxjG2lkAPevAf0jdxK7eObyZF2062OscfOl2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004561; c=relaxed/simple;
	bh=9gDxacpK7cC/KPStck1bD5JAgsuSXM/ojAZPqxLJPM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5jU+c5Yo2Cg8ogxA56YZ4RblDfruFQ3lUA11AL5RlODKLJY2cbMgDDe2RpLoOpb4YjIcREwDPZrWm65BI4xaDEWHjMaRWKSmUxM5QFOR7ht57DmUhn75ebOElEYx5nmgdQGjlf2O2YQuGMcVsSMsRcTh8E/4cytpQpwKmRKHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8FCC4CECC;
	Thu,  7 Nov 2024 18:35:59 +0000 (UTC)
Date: Thu, 7 Nov 2024 18:35:57 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	will@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <Zy0IjTkqlCZ9DRWN@arm.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <3d166642-4062-42ed-9e24-1771cd819110@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d166642-4062-42ed-9e24-1771cd819110@huawei.com>

On Wed, Nov 06, 2024 at 05:55:16PM +0800, Liao, Chang wrote:
> 在 2024/9/19 20:17, Liao Chang 写道:
> > On 09/23, Will Deacon wrote:
> >> However, we should use __GFP_ZERO anyway
> >> because I don't think it's a good idea to map an uninitialised page into
> >> userspace.
> > Agreed, and imo this even needs a separate "fix info leak" patch.
> > 
> > Oleg.
> 
> Given that Oleg's fix info leak patch has been merged [1], the risk of leakage
> is gone. So I am looking forward to your options about this patch. As many
> functions start with same instructions like 'stp fp, lr, [sp, #imm]' or
> 'paciasp'. So I think this patch could avoid unnecessary D/I cache synchronization.
> 
> [1] https://lore.kernel.org/all/20240929162047.GA12611@redhat.com/

The patch is fine with the fix in __create_xol_area(). But please add a
comment on why it is safe to skip the cache maintenance, something like
"the initial cache maintenance was done via set_pte_at()" (well, I can
do this when applying).

-- 
Catalin
