Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1068197558
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088776; cv=none; b=WGZ6ORU1HlF1QtrgVAR8/CIiJoa/sA98yK2Opar5MLOwRsvHtZVX3pQ5EgvebtoJxdQ7ysbU4Gn2VSBLiIa5KU2AlTji8diV3zzmkiS4VUiczm/5b829Wdy6zLvK3RFgz+twrzuUCFP/I35rKKlSdcchNgVoC42S0e8Hv1FpQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088776; c=relaxed/simple;
	bh=Y+sOs23LxoBNVTfS3KszCVfFBU/ZZVHdw76qtjXQLyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzvPCabc2ripWnFaEPF0JPgExZYceqLVwnR1279ZeWgfpJm4HCFMcz0EM/alYi4y6m3tKjG0iF0PnNN/kLGfYw3pa1SAUglH5UdzG1ILn3At/56MoHSHSGF5zjvBiHIN29U8Vo6y/jcafZxKVwYoiSNwQnqTVOAvw02i0vAWcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5+8z3LH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5+8z3LH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727088773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+sOs23LxoBNVTfS3KszCVfFBU/ZZVHdw76qtjXQLyw=;
	b=I5+8z3LHmt2OOEiz7hr2iJ7ReCJQn6DICAMO6eYLTIj1qdzpPYs8RLB191q2bgqW3mVQZU
	BadtiRaUQCnt/xo11BmvvhK4XeYZOuzuiBPpCBAaVuyDTCdZb58TyKUcmmlxhsHAleOgUV
	y3zPjkRDrMakisnUXed5M7dHfovmQR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-_B_MAFsMPKuFULX2GCN3Xg-1; Mon,
 23 Sep 2024 06:52:48 -0400
X-MC-Unique: _B_MAFsMPKuFULX2GCN3Xg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 677B019CC856;
	Mon, 23 Sep 2024 10:52:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 74F6419560AD;
	Mon, 23 Sep 2024 10:52:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Sep 2024 12:52:34 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:52:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: "Liao, Chang" <liaochang1@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240923105228.GB20793@redhat.com>
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
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/23, Will Deacon wrote:
>
> However, we should use __GFP_ZERO anyway
> because I don't think it's a good idea to map an uninitialised page into
> userspace.

Agreed, and imo this even needs a separate "fix info leak" patch.

Oleg.

