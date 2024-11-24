Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03D1A01BE
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732459044; cv=none; b=ac18cJ7UfkZNTOfqUq/whS0mODGDlCRGY2i+ac6b+VILbMIbRcBJCEUEYWPgwADjCqZVUGvgILnjaWH1rA9Mk8hEdNHDbvYV8MH4adXtAbTn9OgECJV1NSE4syjZLsybvfr2/ZtlEeGwk2gT6WxjFLXJ5kV0ZklTlxlhxcnTVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732459044; c=relaxed/simple;
	bh=D0osCoxAykJTnczaqhJcaTt/BAIK19YCRQADyNVqCXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYvAm9Lkp1wIPxLQmH0xZCCjKHFVtIgWrAdURhOATJ8d1YNy1GJBvIfQTbq/7Ig7O1TOKPhgf/nsLtCo9K63deOu6kRsC2+hEPBtah+sJatBh3jyoYBdosDUNYxlOw97qPQR2MAw7tA8U9kclHl7t+tSW4s9PC3FXzIw//uHDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcaAtcVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcaAtcVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732459041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXSyHLXz0KlC88jUw9aNC5a+PM7XVtYTvoW6DGOnU0M=;
	b=UcaAtcVOllzpqDsALU4Y5p6zM2NmEx8zYBiwsEK5ZAYzqEXoUYSAwNrP0HNHPjEBBD0LGl
	rlueAgp7C+6W/JtmnjeUA2BAh8Km6chEqWkW+pe/B+uzyfNRbEBfaOTa2nx5bf9FS027vv
	gcEj2YDHNALm2nvXmCfEsVGV1FSvE7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-iTcgyST1N62no1YePBrvxw-1; Sun,
 24 Nov 2024 09:37:16 -0500
X-MC-Unique: iTcgyST1N62no1YePBrvxw-1
X-Mimecast-MFC-AGG-ID: iTcgyST1N62no1YePBrvxw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D51019560BA;
	Sun, 24 Nov 2024 14:37:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 78D6930000DF;
	Sun, 24 Nov 2024 14:37:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 24 Nov 2024 15:36:55 +0100 (CET)
Date: Sun, 24 Nov 2024 15:36:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 1/5] uprobes: sanitiize xol_free_insn_slot()
Message-ID: <20241124143650.GB28360@redhat.com>
References: <20241124124623.3337983-1-sashal@kernel.org>
 <20241124131357.GA28360@redhat.com>
 <Z0M1HLLE_ufLcGMO@sashalap>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0M1HLLE_ufLcGMO@sashalap>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/24, Sasha Levin wrote:
>
> On Sun, Nov 24, 2024 at 02:13:57PM +0100, Oleg Nesterov wrote:
> >Hi Sasha,
> >
> >but why do you think it makes sense to backport these "uprobes" cleanups?
>
> If it doesn't, I'm happy to drop them. This commit was selected mostly
> because of:

I'd suggest to drop.

> >>1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
> >>   xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.
>
> Which sounded to me like more than a cleanup.

Sorry for confusion. This patch doesn't make much sense without the next
changes.

Oleg.

