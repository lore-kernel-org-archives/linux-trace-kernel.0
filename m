Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEB3672BA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574476; cv=none; b=UC05ndF20IckyDVJZNcNvJ96Z4RJyyOSPAqcQG8n6PstV2HvBDnXACWzUfwwQO/bpTZMK7axnWt3c1Wx5fe+S1lebmAunLPTde0Z3uW76bfnhSXpwyNGB7PEC8GXOtJnc3v8IaFdtX4WQJQY6iFsX0xF6asbzbKSUMRvvSnU4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574476; c=relaxed/simple;
	bh=joffnHKujoU/Gko7D3WXw1qkn5zCkOcUai5IiE9r8IE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/TLRflKRD8wW2U/pwGmiTI1O6jdT4ME83u1d+Vx+qbNt7onkS1TJP+GBpiVD58W9iY/EFQDizR6IrkRHKblQ2AswpQk+KuBoIVfF3ZSYRGQn3WeaojvrRVKY0Hq3UJ1waz/oXsxJRvO977BB8Ztny57vDerrRLkXtOby+Q659I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmJ8V8eY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmJ8V8eY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=joffnHKujoU/Gko7D3WXw1qkn5zCkOcUai5IiE9r8IE=;
	b=NmJ8V8eYXfs4D/lgcOLew0sQgoQ3Gndni5J8bHOaHlS20s91SSGsC8TR5ywfH7fiBw0sL9
	r1Wk2tHAX4qiA1RrE8Xp6LLuRHm1fMplhlNhySQlmati462PLbBJ/PPI4Zi+SbyomF0IVv
	fSTWIXxn0jVPEz21/LsUY6+g/dUK5y4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-lgJzScXWNqCfx0xK7llpWg-1; Tue, 12 May 2026 04:27:53 -0400
X-MC-Unique: lgJzScXWNqCfx0xK7llpWg-1
X-Mimecast-MFC-AGG-ID: lgJzScXWNqCfx0xK7llpWg_1778574472
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so4900915f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 01:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574472; x=1779179272;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGKQtZGC1c4txfn6v0+W7d7uIVSHAwg4MX9gaJVmjPY=;
        b=VeQzV4K5zn0h2vj3v46nM2s3XLxnWfEI9Oii9vli9noZAf4mrDw0pCbTJkLQv4RB3H
         IVbsyErtlAf85ngF6Xg7y3J5V37+zzn0myV1ZGdBT+BTJvLNrbXeuIbxofPTUGIg7Cl8
         THBhpRdjweJJxmCCVRqLNtCf5I18oXUaVvORtjcTZZvox079suUBgaWzlqv83EdoO1P6
         VYVnWQi8jllyRvrNTB1HVex3Mjl4eVP1GjwPKd7EiEKUAXGsZ0s1OQClSBztjiLY+M6T
         RQ12SAiWbgWu7LQZhzlKmhxKnFNAlX7GK6nFVrSZr8L24pRMjyKVrl6Kujuoy2fpR9tl
         aQ+Q==
X-Gm-Message-State: AOJu0Yz6CPsZFdV3V0BBd//OSEDuIK2dTtF1GtkPFtRKvLgXDI+K9LZD
	/XD4ZPdn6yzK/fp1K41t/yl4DsCq3tT9fsAPdyngw0ZNdhGGLy5nEimFCeh/o6DLPlTSHL2Hhg7
	LMITkLr1eK/PV63iZrPQ/O9KbZNZ5R/5PpVP3NL3yELVSCmfFVEZFXACJjqP8KwYIczBPJBvrJ4
	t69pHLeVaV
X-Gm-Gg: Acq92OEs/Kf49Gg/qhYTTegjQgj3Uu5BO2SIo7s9eCv8zWuhm7HJePuyrxIN2Q+YTPJ
	APHRk58F3b76mup6TEvQOKJHnSNRUfiyCJxogYTijPzaW7hHFSTX4BbWkVXfelQPIuf3+9R34vU
	dZ1gaFXpMZ99PRDLOhatyJiGHlV3lPnrGHEpsWoLGLJezhWcwnYwwL4Ojia/A27uQDKZUBYZizH
	4udA4M7zkotg79DJenqQiJGhGvQqAxTE0R/94CSeQoXChoTYLZc+VzrKszLLdTFtc1Xtt3k4zwd
	2venVXjTJigVz5tw1GS2gWXo3GgKBTlgHUL8MbOph8uLYlyMk9s1SZpYHPoqhCGQBrvov9yku6y
	yGxVx5w9YV2drx2YgrPml97gxzM5E5EwA56bBI7BEn0vLF2KCbFg45FTWmvcgZ4AEjK6kkCEg03
	l1Wn3dKI6yHEROC9s=
X-Received: by 2002:a5d:5f82:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-456a46e8db9mr19103459f8f.31.1778574471836;
        Tue, 12 May 2026 01:27:51 -0700 (PDT)
X-Received: by 2002:a5d:5f82:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-456a46e8db9mr19103417f8f.31.1778574471429;
        Tue, 12 May 2026 01:27:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm34017062f8f.5.2026.05.12.01.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:27:51 -0700 (PDT)
Message-ID: <f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com>
Subject: Re: [RFC PATCH v2 02/10] rv/da: fix per-task da_monitor_destroy()
 ordering and sync
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Tue, 12 May 2026 10:27:49 +0200
In-Reply-To: <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5vMlHPu170kfQghgfRwag76Ip6VaJ3bfeABMUYK-tcs_1778574472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> The following two paths race:
>=20
> =C2=A0 CPU 0 (disable_stall/__rv_disable_monitor)=C2=A0 CPU 1 (wwnr probe=
 handler)
=09=09=09=09=09=09=09^ did you mean stall?
> =C2=A0 ------------------------------------------=C2=A0 -----------------=
------------
> =C2=A0 disable_stall()
> =C2=A0=C2=A0=C2=A0 da_monitor_destroy()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_reset_all()=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <------ [task T: monitoring=3D0]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_start(&T->rv[n]=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no timer_setup */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitoring=3D1=C2=A0=
 <----
> =C2=A0 tracepoint_synchronize_unregister()
> =C2=A0 // CPU 1 probe has already returned; sync returns
>=20
> Later, enable_stall() acquires the same slot and calls da_monitor_init():
>=20
> =C2=A0 da_monitor_reset_all()
> =C2=A0=C2=A0=C2=A0 da_monitor_reset(&T->rv[slot])=C2=A0=C2=A0=C2=A0 // mo=
nitoring=3D1, timer.function=3D=3D0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_monitor_reset_env()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_cancel_timer()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_delete(&ha_m=
on->timer)=C2=A0 // ODEBUG: timer never initialised
>=20
> =C2=A0 ODEBUG: assert_init not available (active state 0)
> =C2=A0 object type: timer_list
> =C2=A0 Call trace: timer_delete <- da_monitor_reset_all <- enable_stall
>=20
> Call tracepoint_synchronize_unregister() inside da_monitor_destroy()
> before da_monitor_reset_all().=C2=A0 The unregister_trace_xxx() calls in =
the
> monitor's disable() have already disconnected the tracepoints; the sync
> here drains any handler still in flight, so no new monitoring=3D1 can
> appear after da_monitor_reset_all() clears the slot.
>=20
> Also fix the slot release ordering: release the slot only after
> reset_all() to avoid accessing rv[] with an out-of-bounds index.
>=20
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Thanks for the fix, I have a similar one waiting for submission.

These are technically 2 separate fixes though: the ordering with unset
task_mon_slot (independent on HA) and the synchronisation with pending
tracepoints. They probably deserve separate patches and visibility, the fir=
st
has always been around and we're technically overwriting who knows what.


The explanation above is a bit hard to follow though, are you talking about=
 a
handler for the same (stall) monitor running after the reset, effectively
undoing it by setting the monitoring flag?

Then this is indeed an issue with ha_monitor_reset_env() which expects a cl=
ean
environment.

So that's basically what you'd see now much more often because in fact we d=
on't
reset the right slot (though, again, that's a different issue).


Calling tracepoint_synchronize_unregister() there too would surely fix, but=
 it
used to be kinda slow. But it's probably gotten faster since now tracepoint=
s use
SRCU, so we can wait for a dedicated grace period.

I liked the idea to wait cumulatively in the end, but that's just making th=
ings
harder.. Let's do like this:

Prepare 2 separate patches as fixes, put the task slot one first (would eas=
e
backporting), mention this issue with the race condition only in the second=
.
You can send them independently and I'll add them to the tree as urgent.


I'm soon going to send my set of fixes that will also include the task slot
patch (not removing to ease my life with conflicts).

Thanks,
Gabriele

> =C2=A0include/rv/da_monitor.h | 18 ++++++++++++++++--
> =C2=A01 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 00ded3d5ab3f..d04bb3229c75 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -304,6 +304,20 @@ static int da_monitor_init(void)
> =C2=A0
> =C2=A0/*
> =C2=A0 * da_monitor_destroy - return the allocated slot
> + *
> + * Call tracepoint_synchronize_unregister() before reset_all() to close
> + * the race where an in-flight non-HA probe handler sets monitoring=3D1
> + * (without calling timer_setup()) after da_monitor_reset_all() has
> + * already cleared the slot but before the caller's own sync completes.
> + * Without this barrier, an HA_TIMER_WHEEL monitor that later acquires
> + * the same slot would call timer_delete() on a never-initialised
> + * timer_list, triggering ODEBUG warnings.
> + *
> + * Note: tracepoint_synchronize_unregister() is a system-wide barrier
> + * that waits for all CPUs to finish any in-flight tracepoint handlers.
> + * The caller's own __rv_disable_monitor() issues a second sync after
> + * returning from disable(); that redundant call is harmless on the
> + * infrequent admin (enable/disable) path.
> =C2=A0 */
> =C2=A0static inline void da_monitor_destroy(void)
> =C2=A0{
> @@ -311,10 +325,10 @@ static inline void da_monitor_destroy(void)
> =C2=A0=09=09WARN_ONCE(1, "Disabling a disabled monitor: "
> __stringify(MONITOR_NAME));
> =C2=A0=09=09return;
> =C2=A0=09}
> +=09tracepoint_synchronize_unregister();
> +=09da_monitor_reset_all();
> =C2=A0=09rv_put_task_monitor_slot(task_mon_slot);
> =C2=A0=09task_mon_slot =3D RV_PER_TASK_MONITOR_INIT;
> -
> -=09da_monitor_reset_all();
> =C2=A0}
> =C2=A0
> =C2=A0#elif RV_MON_TYPE =3D=3D RV_MON_PER_OBJ

