Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629F2D323D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916021; cv=none; b=FWvZh+NO9HuOMMC/668WFtJDrlPqnRenHBjn1VH5lmQVIpT5vFWHzOr8VaZrQGFvuiIwvXUDGSLViAISVQoW5VX7M2YE7bH/Ct9mfaMcabYVmOC0QwRg7e3HZ5hgjBhL17Qm8zNYUg1uuttCZ92KP+Mmqm6Svr2Se2X0XSfAGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916021; c=relaxed/simple;
	bh=bZ8JvErxR0ncMluhQbck3byby1FATW+QySRiWFQS31Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jlr8jmg0vKVGh4xM0ObfzeWchhOpH0HN3xQ+SAmiyinPYNYXZxpaoG/grQdoxxFUCg1l9Efy7QeNEHD8PUVrSFCQHzkG+fhbYuxCNLHi3MEipZh0mbWcqjNu6LxwiRoEUafcisp0aytF56gfFJ8AB5EKOpzGtnYtNRxPAPuerkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaPvPzUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaPvPzUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bZ8JvErxR0ncMluhQbck3byby1FATW+QySRiWFQS31Q=;
	b=JaPvPzUFwnpKkqMhrP2J5jrpI5RIxAn+pMMsRk34H2FNw2SU3Yt5a6F+Vyk7MdifQ8znNV
	JXKhBU+9oeWI0pZLuumsZiJ4GmIQmhK09oViBWXrp9+k39jLoce7GY33bC3zaw10UG5f2c
	ZdvzH2sbSxEo60poanJdXAbFugT9cKU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-tSOLMPh6NDmVGNiZMTCeVw-1; Mon, 11 Aug 2025 08:40:17 -0400
X-MC-Unique: tSOLMPh6NDmVGNiZMTCeVw-1
X-Mimecast-MFC-AGG-ID: tSOLMPh6NDmVGNiZMTCeVw_1754916017
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e82a101470so801809485a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916017; x=1755520817;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5BUV8YhRn/Ax4dIkTjLV1BItSPJ4aeJpn68BpS8ZZc=;
        b=k1L1t/KoPf/oDHYLehTPBYZqYTaH9CrAKREqUIyyxWS1foS75/1U7yC0r7LHpT1lP4
         stEAKKKtXFmHHFLQgOCZH7Q6uGb6MvmKVX9gAJFxVv1uhPcUcaYRxCC0GW+4lDA/74+e
         3CIyTOEkO/yQqFgn+diwfCxkbRKDQ6wlnlfP2ClZdBYxqNFumxFSM6XGa4ebzn2lESr6
         w9N6sJRLYjykszKA18FSOnGzPbPspvkA+mdR3r2p5aTJCXVf8VsPR9de4StuGH54a4Rk
         BHdNnIUVEveqCnu84uty2Hp2bjj1pHiklO20aC3hzntAtmpzoaCA5AtD7coTmileoyM1
         niDg==
X-Gm-Message-State: AOJu0YzuWrGbfX8M4raiCkIf07dd0v8BlzEluIRTSqRez+Gd6Pe5mEUR
	wWaDjELWFKDspPzwst1eH8tdAomiVkn5RFDdD4aDPcuCnMT9+jI7KITgbqC9yy2VEFpZ+tLQq8H
	I2xPPOax8NuNmiupEJsI27myVe6cmfirpM3ONQqaLGwDtrA+5G6KsVbqW4Q6l0Q2BNkRbHcUzTw
	==
X-Gm-Gg: ASbGncsvZgTP68ht3KNJjOFpD86rAgdTB3sw9342TnmD/i1K0Hq9oEMOz6cHPLxJZvY
	yQguxSuNP5qnTT8KhNo7vAOAT/PBzwNgLEnwi6SMCKxdpzRSM1GJi829sV2VzuU5Tkay1/EhhmT
	HmeEzLBtWdAJlFII4K2UcDwh8YnKWRuVVBjy3DEFwebbm6bOvpNINpQILjmfnX6PadjNYS7mJ5P
	OwFBkcnBXs9k70DNKHpvWbR2qPFYbxJFqMomqBuXGGcXjk/RdX0pdwKO5EfznI+DiE8A8MjHYRL
	aRTeimQJPA9GzVjEgaEBqoz8RXjDY7HPtZiQZXqbyayhKE1km7Btk40j8MN74L5iFQ==
X-Received: by 2002:a05:620a:a50c:b0:7e1:9357:85df with SMTP id af79cd13be357-7e82c7bcaf6mr1624713185a.55.1754916017068;
        Mon, 11 Aug 2025 05:40:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG9QTo9AdNmsvOYlTc5kHQZC3mxnMpfJ5588uXlgec0XggbhPVrUQNodSuN9JBendrRyxPOA==
X-Received: by 2002:a05:620a:a50c:b0:7e1:9357:85df with SMTP id af79cd13be357-7e82c7bcaf6mr1624708485a.55.1754916016521;
        Mon, 11 Aug 2025 05:40:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80235288fsm1093882885a.22.2025.08.11.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:40:16 -0700 (PDT)
Message-ID: <9e3d1c141c1e6609252aa38348986fe1436052b7.camel@redhat.com>
Subject: Re: [PATCH v2] include/linux/rv.h: remove redundant include file
From: Gabriele Monaco <gmonaco@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Date: Mon, 11 Aug 2025 14:40:13 +0200
In-Reply-To: <aJneRbHGlNFg7lr9@bhairav-test.ee.iitb.ac.in>
References: <aJneRbHGlNFg7lr9@bhairav-test.ee.iitb.ac.in>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8VPJRIPtpHH8KhiDMwzj3Fc-nYwweDB6lXs0T1RdrNY_1754916017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-08-11 at 17:42 +0530, Akhilesh Patil wrote:
> Remove redundant include <linux/types.h> to clean up the code.
> Move all unique include files inside CONFIG_RV as they are only
> needed when CONFIG_RV is enabled.


> Arrange include files alphabetically.

That is usually not necessary. Also, it shouldn't happen, but sometimes
the order of inclusion matters. Anyway this isn't the case here (builds
fine locally) and when it is, the test robot should notice.


Looks good to me overall, thanks!
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor") [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> =C2=A0include/linux/rv.h | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..9520aab34bcb 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,16 +7,14 @@
> =C2=A0#ifndef _LINUX_RV_H
> =C2=A0#define _LINUX_RV_H
> =C2=A0
> -#include <linux/types.h>
> -#include <linux/list.h>
> -
> =C2=A0#define MAX_DA_NAME_LEN=09=09=0932
> =C2=A0#define MAX_DA_RETRY_RACING_EVENTS=093
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> +#include <linux/array_size.h>
> =C2=A0#include <linux/bitops.h>
> +#include <linux/list.h>
> =C2=A0#include <linux/types.h>
> -#include <linux/array_size.h>
> =C2=A0
> =C2=A0/*
> =C2=A0 * Deterministic automaton per-object variables.

