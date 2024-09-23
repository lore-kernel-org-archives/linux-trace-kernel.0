Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C114A8B;
	Mon, 23 Sep 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107441; cv=none; b=owuJS4WQ2Ume+gr4aaWjhWWhHin9qSyAc0R4D6Z3/69NfWVvfDI2IWspEAcu16cW1hiiJNs4yBLsAT2NX5vBbO56G7hlSFLdgaMb9ylAAmnh5RCO0NdmSmz18kllfp3ikH3RNAPxM84j8PAFgQjmY1fi8CiAr/02MskpE3uwxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107441; c=relaxed/simple;
	bh=0mEJ/dawlRKh0O4jYqFhB00pGHwtBHJjZiyQBB7qDT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q62WEQzwyFvKU4X9Zgp4OCLXilbD2F5G2+kkE8fCD+edToJ4LGFg6J92misijMbakX2TK7MszGXjnWuGNzgjLahv/BZbY4U+95kvPf7csfxWzBSWUMQuA9xSVlCmuB2Xs0tv9W2PAUlinxZh8pL6nttzpjwHO/CdR2/N32Ua/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB45C4CEC4;
	Mon, 23 Sep 2024 16:03:59 +0000 (UTC)
Date: Mon, 23 Sep 2024 17:03:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: "Liao, Chang" <liaochang1@huawei.com>, Oleg Nesterov <oleg@redhat.com>,
	mhiramat@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <ZvGRbeAtpAkZVhLt@arm.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
 <20240923071856.GA31866@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923071856.GA31866@willie-the-truck>

On Mon, Sep 23, 2024 at 08:18:57AM +0100, Will Deacon wrote:
> On Mon, Sep 23, 2024 at 09:57:14AM +0800, Liao, Chang wrote:
> > Unfortunately, the comparison assumes the D-cache and I-cache are already
> > in sync for the slot being copied. But this assumption is flawed if we start
> > with a page with some random bits and D-cache has not been sychronized with
> > I-cache. So, besides __GFP_ZERO, should we have a additional cache flush
> > after page allocation?
> 
> No, I think Oleg's right. The initial cache maintenance will happen when the
> executable pte is installed.

For some reason I had kprobes in mind, did not realise that this page
ends up in user-space. So yes, we have cache maintenance when the pte is
set to point to this page. Subsequent changes will need cache
maintenance.

> However, we should use __GFP_ZERO anyway because I don't think it's a
> good idea to map an uninitialised page into userspace.

Oh, that's not good.

-- 
Catalin
