Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7452F6924
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561294; cv=none; b=YTb92Yw8YpT7ngfpovsETaNNfT/u71+a69FNmfL6Kc8axSB1XLo12ThQfWDk2wBHZhy8KJk1Vf2sE1CMekE+w2364D6hl0xfbAq//Ps5GMqiXytWKfmC/swkfRi11h46krboLHenTr4BlJQEY+L378U1/OiVs5lvZuY3O6eHlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561294; c=relaxed/simple;
	bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3o13pQ2QMQODOiLqiaTT9IMcviyPrWaKMzsgxfn0Fptwwod4g9AASc8YIhSMEJnvUQLY4ShhUhBvO6Vk4pRV4Jq5Dkjo29VWteGUu2lA79PwAKie6WsrAkSWfK8MOYuq2y2n7J4CytsioVO7EU5zcjFDBoNfjCVUzxmstQOgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSOGqmRS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSOGqmRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761561290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
	b=jSOGqmRSqqOechJ8OzUt3h5hyWUQ4+/kqeGp6BdE/Sov8+hfRdEGCxuv+flTv8VZNB/n3w
	xnu448uvraqdqMfPxw7cKzLZetO94hTt6I/yhW3kuVTVfhsJlD+GY9C/BFoSvzqvtyCwfS
	KsLPVi1ZXZeq1YJfTww1Z/OBa0QlR8U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-pWg73vJDORSh2K-3rMFswQ-1; Mon, 27 Oct 2025 06:34:49 -0400
X-MC-Unique: pWg73vJDORSh2K-3rMFswQ-1
X-Mimecast-MFC-AGG-ID: pWg73vJDORSh2K-3rMFswQ_1761561288
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so276392366b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761561288; x=1762166088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
        b=oWjcsNLzuQg65/odM1SUKNVaEc8QwxbKqmuC9CVESrSI7OpxzKDIWIYkGLaW84Yc02
         kbLk0NaxbxXNlOEKkbxzITr32bmtsjtbjVtWE0m8P5sW6lFX0I22SAXnNAXQvBdZVK5x
         NZHIKrEibOQiE+UqUfDGonurIZDn/MMmI2xbMG7WskDjeaTKuyhiNSag3Fh6BNkiMSg1
         1Wnc92t5hx9m4pPSoUraA618WLUQ62EQphvjb51xunvqhLRfRS1yWmlKl1Jj4b8H2H05
         Yr9AvXkfuRk5KqyCFkawr2WlW4NFdGzijbZPcpjPKwgl0E3iYUFY6181KgCqZGdbHre6
         XVVg==
X-Forwarded-Encrypted: i=1; AJvYcCU0XEK+3PfYFJ9BCtL3hx9IiJDG+59C5loTXhNzfo/4OawCFTpC8nxT1/Zu24ODI9GRGWJCFmT8d0BbJIs43cSvcu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EGsoRuw0oFxdRYiKUVQQNHNBB4HZLstp40sRK16fVaP5KBTA
	Pd1z0qLrAvxD9pHRRgscmwih5TgzRpRmbklrjJzJQ2IUPKaPquMrKBbhVtoR1NfSXJY2cXEyBAR
	4S2sh+e6STvVvASwiifwVzj5GAW8x4PN+c/iZqsTkStFbrm90iA55snpp7OnlU8h6oz7gSTcr0Y
	I77k6cn/YzBlt3VLdQHPVRnde3vt0AU3TqxyTVvuH9SI+mVCcW
X-Gm-Gg: ASbGncsCQG96CNXnpTmUHlCKRKAoEy9SrIPiI4KEg7gNWo7mL2JeAV6mkWzcTDVcrAM
	Pohso++4UM1rKHByj5ZLz5wsoBKOC5zDGMCgL3I92XBfRjZlsH1Sfc6E8/KruWm13Mckc5a/RnS
	z6v5BrzNMeskXQTqNw38W8YEphrdf82cGVclb1/oyrhJiNO2P8Y+NAKFsZqQYGpv2xfJz58BcMI
	T8ZBzBkVjM9Ww==
X-Received: by 2002:a17:907:9725:b0:b6d:5338:f6e6 with SMTP id a640c23a62f3a-b6d6bcfbbf1mr1050211466b.18.1761561288052;
        Mon, 27 Oct 2025 03:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHibjOYCk2sKkZzgs00m9DngU0+qufH2rg1LAx0LsarP6NwDbhgx9VF+0BCzU6yodoPha+MLbmyZv8fOXt2cn4=
X-Received: by 2002:a17:907:9725:b0:b6d:5338:f6e6 with SMTP id
 a640c23a62f3a-b6d6bcfbbf1mr1050208466b.18.1761561287510; Mon, 27 Oct 2025
 03:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017144650.663238-1-tglozar@redhat.com> <20251017144650.663238-4-tglozar@redhat.com>
 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
 <20251021130232.2ca75863@gandalf.local.home> <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com> <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
In-Reply-To: <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Oct 2025 11:34:36 +0100
X-Gm-Features: AWmQ_bnyHDmK7R_EUxRmXlMxvG0jeeU550EUjV6zxo81kllIiout1FznW4JnhgE
Message-ID: <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AtO09k1gCkqXcJJcDSVGfgJ4G-WC89fjV7l-2ZZhXls_1761561288
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 24. 10. 2025 v 3:49 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
>
> OK, but as far as I can tell there's no way to get the non-BPF "stop
> tracing hit" messages without adding a call to trace_array_init_printk()
> into trace_osnoise.c.
>

I'm not sure what you mean. The --bpf-action functionality is
exclusive for BPF mode, bpf_trace_printk() / bpf_printk(), as Steven
clarified, is a BPF helper that triggers a trace event, defined in
kernel/trace/bpf_trace.c and kernel/trace/bpf_trace.h.

Either way, it seems that the event is not always recorded in the RTLA
trace instance due to a bug. It might have something to do with the
trace instance recording both osnoise:timerlat_sample and
bpf_trace_printk, and failing to record a trace event generated during
the handling of another trace event. So this is not a reliable way to
test the BPF actions feature, and I'll probably have to use my
original idea.

Tomas

