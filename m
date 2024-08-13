Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354B19412F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552615; cv=none; b=RG11/MNHrRzT4Gpv/58l8yehIIesOM5ScYVnCBlTqmbX9ax8KlXjuPCo0ThP5m0rxfERdMR8+aE1HctyHX25VTl4HgjhepRNj4MgO3beP3vhahKVlrojbPFzdhnZHIRsWxKHdC7yqa+vhWUTcSn3qtqYS9NSD0vTkLb6eqNa9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552615; c=relaxed/simple;
	bh=68SsCUaNEsnCqAjErgExTVGZL/KYU14liaZVe7k297U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8tKtyfa3NIkqWpF+UnymulCLXWfYKF59tHlM2LA8ZLu/gvz291iN5qlYpIdnO7nqNFBu3dM5Z4/vXwmI9TXHahR3nUDFntM59YTGvPRqT0Wc6g/ExFHQYp/2IEeec77oqeOMURN/mMnCeaWlaCgCOAlzbdFyObdmI8Y3+f/14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBatn2AY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBatn2AY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723552612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0TUSbcTCIH1WGQQ2wF7pJ/BOblSyxCtN4itWRR3eIo=;
	b=PBatn2AYRQGgQuW7b7VqO6reXGKBNfL17CHgl7uxesWPM86AioFsxq76xFZnMX2CQz+i46
	B/qQiE+N1yvdM670QQCC+eBVGGLDxZu4R4Yh4/UnoKfxUlFLWK07c0w9fDcVUmLwz1KRVw
	zxQN2ioJcbPWzi+kgaUn8Yeqq8ElTj8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-bG1DWg6cNnKRavA1jD4QTw-1; Tue, 13 Aug 2024 08:36:50 -0400
X-MC-Unique: bG1DWg6cNnKRavA1jD4QTw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef233fb86bso57207011fa.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552609; x=1724157409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0TUSbcTCIH1WGQQ2wF7pJ/BOblSyxCtN4itWRR3eIo=;
        b=IrFnje8EVp5pGwtlWhjtufoXIK/8xJRJ2hvjDmoWkN8ioX635NNGO33lwR3eMNUGT9
         ihtFmehF1bzfPew/RqEUGIsq4jq64syiwSaQjMTW7Hz+XgNxXiUOvmDtZ0MXw/pJcB3m
         D9HIwPH9EjZteRko+/dZjpAUO7qdLiGB8YgQ9FaJQ60zukx99BuCjhbNfPX+Y9tzVch6
         SGP+98b0lp/CBgXcRjNe/Z/tV+tuESMMusDEwp7KvinvCbb0X/Fm/2CU4XUtOqvXkNQn
         n1x/h/WJJgUEfaOfU0b0jnhLRz1IO7rI6chKVvZ4UApsrhJ1Wgl60Nk5nSGPgjOVAqfG
         0SEA==
X-Gm-Message-State: AOJu0YzVumx58JRLQkal8oH8MZ9e/aCVSvMdUVeE+gKoCJT0uh+uLr4U
	ePAXwPikzg8BzIBnnTW8DHCeYKekQtSdZ4wUXtR1wh6+/vNF+OnXP78982/LJJEZ+6d8QR1I+vy
	3fw/qkUwHeVoJg4jFQr5WEtN0izP+GWVNVxTFDKAyoN3gBIW5Mu4IUlUVQ0jTN9HQyQmhtDaRq6
	r2KIJAvfJ4D7b7eZ/MXWJlyfMACGJ5lpfaWI2JerHTKrzw
X-Received: by 2002:a05:6512:3d86:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53213692a78mr2562627e87.52.1723552609339;
        Tue, 13 Aug 2024 05:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7BlMoT6OL41Ug/pNECmFOkEoEPNi3/UKnqqTuK9qlZuO7CRYCYGlTo2lbdBTKuEA/yp7JLiadree+/Y/FFMs=
X-Received: by 2002:a05:6512:3d86:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-53213692a78mr2562595e87.52.1723552608809; Tue, 13 Aug 2024
 05:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813114931.360823-1-ezulian@redhat.com>
In-Reply-To: <20240813114931.360823-1-ezulian@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 13 Aug 2024 14:36:37 +0200
Message-ID: <CAP4=nvROfKr8s75B=POefQozE88se6zrfPcfaP_n5TqtXY9ABQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: Sync the help text between hist tools
To: Eder Zulian <ezulian@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org, jlelli@redhat.com, lgoncalv@redhat.com, 
	jkacur@redhat.com, williams@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 13. 8. 2024 v 13:49 odes=C3=ADlatel Eder Zulian <ezulian@redhat.com=
> napsal:
>
> In addition, fix a typo in the error message generated when the
> specified duration is invalid.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 4 ++--
>  tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

FYI some of the issues you fixed for hist are also in timerlat_top.c:

        "      -d/--duration time[m|h|d]: duration of the session in second=
s",
...
        case 'd':
            params->duration =3D parse_seconds_duration(optarg);
            if (!params->duration)
                timerlat_top_usage("Invalid -D duration\n");
            break;

and the "Invalid -D duration" (instead of "-d") one is also in
osnoise_top.c. Those would probably go to a separate patch, though.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas

