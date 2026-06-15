Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5128751B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518612; cv=none; b=X/e795+aD8Cw6ImwvlDU8hoNPAd9ZtJNEtkmBtAHe42HlZQG5hUnKroGfzO8UeD/EwQZmIpmgToX4d4zdavILSx04QAdVMNvVycSgx+yiJmUzWoUgbRC2F/9hnmNzY0/fkiZTkGrppVvqQ+Us5DdXpqFEOTDP1+OBzlvJ7w2slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518612; c=relaxed/simple;
	bh=Mo5D9pftRRdLfq98Ff3HRb8kYZNL9pSa72WyzjD9yQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsr7dRrRtDu47APHQBpwR+73HDmUSywGPV8eZIHB7glzVip0A1+/SBtwRIiWimKIaMaiOaWF/pbKbH1qJ5AOwfSK8rJtBrgPMfYje2km01AWEBIZmJF0qlP2L95pj0pJs5kacfBEF96X6vr/jJ3byCc8qD+1VuAy6NFHqCfOsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUPgq0Rz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUPgq0Rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781518610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfQahNTR/qCflEV1/g+CfUgr2raFJVwu237dF4iYBbw=;
	b=CUPgq0RzbfSI44KWxz2YXcVvUrZxr8uk4rprqCpajd+lMCKpVjSEPqnz/CuLBps+r6lVMW
	HI8+qJNCNgR2M/MgltAxIdSOshz5JRsrFrB66RnLFTWUKgn6zrjwejJfBKf/jAFVpuJ4d/
	vrL9nhjF7oauNKSLDHO+OgieLKqK9B8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-K7GonlYuMS65LvJ04zuiXg-1; Mon, 15 Jun 2026 06:16:49 -0400
X-MC-Unique: K7GonlYuMS65LvJ04zuiXg-1
X-Mimecast-MFC-AGG-ID: K7GonlYuMS65LvJ04zuiXg_1781518608
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso24080725e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 03:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781518608; x=1782123408;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifgmHngHlOW81FXrm/XhNVyLDbeBXyD2thQTAQr71UQ=;
        b=YiptB+iurxwMHLod/cCd3oeQv2tRVF+Gpxs7g5Aj37g97vrQ1uKLVUOQikpVMqcsj6
         2cQ+2TbRuvjLl7h5oyGy8X67GALi+QmE9rt3B/fAmHu60N5Ubd07RuaceZlpEvVp91Mp
         HSFHnemjg5n+04divOYF07HjnfDpcXLr0Pvclj9VahlAdxKzSfwgCUTNmlEsIfpvjDSt
         OG59+lUQCWK24uAsb/y5gnSEsJexiBifeOuaySZT+hfTxzIlwdsBLYCpcrvYfbS3WXji
         JtQ4VBbZJBeFw6f0clwdjpRu8EcsOoWuS+XZVIQyRhRMiErxGg78qsKjGxWFpfGzxMDc
         wc2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/w1n9oTIA5VUsdQ4bSZUucDOycwQE/SfJIP7f29SOWLtIVY5yRW1PKbqhPkHWIRTiDHgrvs/nAWSCg2DyGK1Tvd+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfWkJSmjpT/lGdbmzQNFdEH/3wlS84ZCLVjNGegIKX0B2BuVm
	BMeqeXo9hj450yd61pbJERkHKP76XG3fYrJACPINqMn2efMsnmlyraSle/pdxkNGQre31NoAosE
	uY5SIiBO1bv6eh9Rl8MkT5xIRSDKSO1DIMw4RRQJDhDh2/Gn/FR4783INm4XM6KNyQ1uiMOjMQw
	==
X-Gm-Gg: Acq92OHlCqtlP1ldn9BF4y6Tv+YsDw+yJrzDRL9pl6KttmcRCIiUbfX4zpmEs5T50vL
	z5lggRI0boqGhKBiXmesZOikdRAxflwNTInMJAQHAdS6po+CPdIjj7E+K8AolnSvivDxwQOiNVp
	4PNBAosRD6CsvZyqZpR7qd5w8/PSWV7/umpS26q+UOBDpXL1Twc8587uvVvHeOmQzzas16hcDHu
	0K03eJyvFh4yGcoTW6dT9ENR3d8qOxC8Uuld2HG/U8E+SwSElsCnh315enYe1sjau6I2bS6zulc
	5zkYj69sf3tpeCzfNopsuwuB28eA4yHNuosyhfx6Ju+SwhAl3m8XD9Ti6+KparO32lh7IEiW+we
	XzbyxwAN0mkQ8mRMszGrvrd9vLA==
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-4922008485fmr124792415e9.7.1781518607649;
        Mon, 15 Jun 2026 03:16:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-4922008485fmr124791905e9.7.1781518606960;
        Mon, 15 Jun 2026 03:16:46 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm29193483f8f.32.2026.06.15.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:16:45 -0700 (PDT)
Message-ID: <17cc39477d7150de668a20ccb71044dc5708695e.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] rv/ha: make da_monitor_reset_hook and
 EVENT_NONE_LBL overridable
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 12:16:43 +0200
In-Reply-To: <13a25b73c9fdebd26c2d4f922a83408dbcfc214d.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <13a25b73c9fdebd26c2d4f922a83408dbcfc214d.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4DvGWINm5Qt2oZdurxsYHOkOsObUDL5joR28r_eP8FA_1781518608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Wrap the two definitions with #ifndef guards so that HA-based
> monitors
> can substitute their own implementations before including this
> header:
>=20
> =C2=A0 /* in monitor.c, before #include <rv/ha_monitor.h> */
> =C2=A0 #define da_monitor_reset_hook=C2=A0 my_monitor_reset_env
> =C2=A0 #define EVENT_NONE_LBL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "idle"
>=20
> No behaviour change for monitors that do not override either macro.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0include/rv/ha_monitor.h | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index e5860900a337..610da54c111f 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -36,7 +36,10 @@ static bool ha_monitor_handle_constraint(struct
> da_monitor *da_mon,
> =C2=A0=09=09=09=09=09 da_id_type id);
> =C2=A0#define da_monitor_event_hook ha_monitor_handle_constraint
> =C2=A0#define da_monitor_init_hook ha_monitor_init_env
> +/* Allow monitors to override da_monitor_reset_hook before including
> this header. */

Just a nit: users can do that but shouldn't do it mindlessly, so let's
add a line like:

  "Make sure you still call ha_monitor_reset_env() or reset timers
otherwise."

Other than that looks good

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> +#ifndef da_monitor_reset_hook
> =C2=A0#define da_monitor_reset_hook ha_monitor_reset_env
> +#endif
> =C2=A0#define da_monitor_sync_hook() synchronize_rcu()
> =C2=A0
> =C2=A0#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE =3D=3D RV_MON_PER=
_TASK
> @@ -75,7 +78,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon)
> =3D=3D 0,
> =C2=A0#define ENV_INVALID_VALUE U64_MAX
> =C2=A0/* Error with no event occurs only on timeouts */
> =C2=A0#define EVENT_NONE EVENT_MAX
> +#ifndef EVENT_NONE_LBL
> =C2=A0#define EVENT_NONE_LBL "none"
> +#endif
> =C2=A0#define ENV_BUFFER_SIZE 64
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS

