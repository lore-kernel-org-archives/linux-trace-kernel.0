Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6D30DD13
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513671; cv=none; b=GJ8oChWiySf+JmAnYrgTe/ebNeYooptkuBLfbr6Ilyi0ceiqb9l2ysYqDowok26DB0gcbwl3D4t1eq1uL0S2qAdd/av2DRqhLkYoixebx+Vnjynaj1I05FRMkfU0C4Xi7zSKA5WgVpBbaHB/RtE+oe+ofDnONgsLnbLFUGg3zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513671; c=relaxed/simple;
	bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt6A1SCuRVH4xVXQuaxoObCTl4fZb05MaXdOdTKXuAOJD3eO5BygrE41KAEUo6SJNX7+98MM67CTPTpnUCnOBtzMdmUrIrwtqwAGBQkaAIop1UWlWvMCMyq1aAy0zx3nDNheSrn5t3kmvG9MDWvn5QZEH7B1KVZj4EdpnX3ibko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2KCJV4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2KCJV4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768513669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
	b=V2KCJV4vfJPv1Iorv0na51f8MgFlqEas3AR2zP2tstPb7ZKjFTajcYk89/l5orIc+l/oS1
	8hSaaRStVsXkASsMRmuk5dCWXDbaI7T6A9dp7xOcoqsR2wqRv5kuXhMmoxzFQhONDvjYUk
	dRYh4slhRPhJ8Rm/Vf14IqaSvQj1Qrw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-4OMGc4KFM2WmH_UC1AOHhQ-1; Thu, 15 Jan 2026 16:47:48 -0500
X-MC-Unique: 4OMGc4KFM2WmH_UC1AOHhQ-1
X-Mimecast-MFC-AGG-ID: 4OMGc4KFM2WmH_UC1AOHhQ_1768513667
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64da80b3699so2249328a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 13:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513667; x=1769118467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCW5sOP/ESj8oV7KJ8/qmtPccfRKp9CrtLbKlhDvVmU=;
        b=iVxM7bySHRqQyuFor/VTIXU8lmapX9H8Pi0xzT27Jca+kP6/KyW/1GOljh1SF2OMc4
         tyLK03ytkSX6so6isB5zMneKGLirVsi8UwmF3jHggqQbuGk+oM/zEdqWa1NS0YRrzMlz
         j15xObxD2OFRNn/8jI8UR3aveh5s0xpz2jglE9W4xnMhQ94ps+9qgmwLUKMYnCTS3xip
         q4a7XR99Mg7xsGMQi3XU9xFbonxSVGVF2bAoFkGnC5XSmn6dYXqvG0rxGKrkRq4v+4e6
         T/Fv2uzeyNGnFp6sV+WRXIWwISDToxhzykHgoPuoNg6Zdl2X3VjzgcvyFuRYJB9V8J1F
         N0JA==
X-Forwarded-Encrypted: i=1; AJvYcCU/GUMI/SuOd+2aJ/ASCxYF5jn8zVzZ7d28D1Kf+G5H0LT4tWG10baTttt8NMZzh92ItZJzF+N1f5ls3BrVu93l6Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKw5WmMsZtju1TRXx+/hldOjH5iRTxOX8CqdAkuZpEWTn4tW7d
	qhYM+5hHPd4/V7944Ed30pMZd1jGQWSbTs6rMYvBYS6hNjcjZr+8KRFndXRwUn0Qr6FcwT0mEwk
	KqrfVERLpboEWLJug9NzK8G7PL0eWTPPrc8J7MDRJfRac1suhtiSMde1hZ+1H6d70N28cPDPUic
	m9hpJY+X0dWjxSb2DAUlc/bZV34LBGyrRyooN9C9HxELpFliEU
X-Gm-Gg: AY/fxX5uTc+I5G/Yh9736KtLSWskshnJJv7n9UBFhCXFLRgUDfUaOOqvMxDQfMbEHVG
	hWHBxKmAsQPNpQyz3FFnA8iSisz73Heat3eaf3keIxwDO3yV6ivWEWsUHh0ciYyuxspc0y2EWmw
	0UMttAPj9XckHpyy4S5eX+jMb06w8yModSFb6B1mb6GZYRpuEetiXfU/ihalAqJiKvMDZGwRDDI
	3o0izl1KaitL1KEOOklrY6y5w==
X-Received: by 2002:a50:8d8b:0:b0:64d:2822:cf68 with SMTP id 4fb4d7f45d1cf-65452acb34cmr460640a12.21.1768513667082;
        Thu, 15 Jan 2026 13:47:47 -0800 (PST)
X-Received: by 2002:a50:8d8b:0:b0:64d:2822:cf68 with SMTP id
 4fb4d7f45d1cf-65452acb34cmr460627a12.21.1768513666696; Thu, 15 Jan 2026
 13:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
In-Reply-To: <20260115163650.118910-4-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 15 Jan 2026 23:47:10 +0200
X-Gm-Features: AZwV_QgmE7V_w2qHIpX_JB5LIS1_ZBI1TTwK4IhXV8NP7XdRm6XAytzFx6veMZI
Message-ID: <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VlIWeQLfyf9pDy9F6k2Cu2h5pqSvgAtrVolaC6WJqDU_1768513667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 19:25, Wander Lairson Costa <wander@redhat.com> wrote:
> To simplify and improve the robustness of argument parsing, introduce a
> new extract_arg() helper macro. This macro extracts the value from a
> "key=value" pair, making the code more concise and readable.

Would you consider using getsubopt?

Costa

