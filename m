Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE115B96C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366930; cv=none; b=Sf6PPvao/59aEJDCW/cRrCv+o5inbJyvnL9ffC/8ThHJ4laaKncL5KyIBdRuxbXTKe9W84sq+3jxkxICR0Xh4KFTF9D8XpXGMFElfuSVOG3EMG6nhsJ0b1o3mTKbQ5+FRpUEQUy2velqCj7rwOX2sBnAiDJTYr/XdJBGsCAhS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366930; c=relaxed/simple;
	bh=Tye5qerO5CBCY8lsDm6znBw3VH/UFoDPiSxLCCPG9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfyGUp3NIS4YO6zEx9DBKds1Aokqow9aHS8/g3Q952iHyckPxU78eGe8MteDOKHM1KIz3k3l7gJnZA3yL+Qv0ny39cZuw+aL3yvOTdc130sOjKatUbMKUE0z+8NQJj5egG7hk/YcJr7vjRY/1dJBeCnt/8bW9g0PSU8ox+OV1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8qCmsUh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8qCmsUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727366927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tye5qerO5CBCY8lsDm6znBw3VH/UFoDPiSxLCCPG9w4=;
	b=S8qCmsUh7nvukf/56QwaWlcwsoPzNusxbMQlfVYE4di0wE+l/s/vA+3Gj+2VK3W6+9XZ34
	eziHzaGmvYJxJ3/6PliYSrHjmCfdzLYONR4i0r/JKM19+++qMi7/aeLcJAxyQmtLYQCjiX
	7oPmCjr76Dsn6t+7AwV4juxPYfcBAT0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-FPkTXSsUOLG-ml5MbKYVPg-1; Thu,
 26 Sep 2024 12:08:44 -0400
X-MC-Unique: FPkTXSsUOLG-ml5MbKYVPg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D04419792DE;
	Thu, 26 Sep 2024 16:08:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.133])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7C22E195605A;
	Thu, 26 Sep 2024 16:08:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Sep 2024 18:08:28 +0200 (CEST)
Date: Thu, 26 Sep 2024 18:08:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240926160823.GA2592@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
 <20240923071856.GA31866@willie-the-truck>
 <20240923105228.GB20793@redhat.com>
 <522284d3-9655-3703-00e9-33f358dbc78d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <522284d3-9655-3703-00e9-33f358dbc78d@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/26, Liao, Chang wrote:
>
> 在 2024/9/23 18:52, Oleg Nesterov 写道:
> > On 09/23, Will Deacon wrote:
> >>
> >> However, we should use __GFP_ZERO anyway
> >> because I don't think it's a good idea to map an uninitialised page into
> >> userspace.
> >
> > Agreed, and imo this even needs a separate "fix info leak" patch.
>
> Do you mean to fill the entire page with CPU specific illegal instructions
> in this patch?

Hmm. Why?? No... OK, I'll write the changelog and send the trivial patch
in a minute.

Oleg.

