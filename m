Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB0375F6C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787915728; cv=none; b=YpFqSexFAZ+KQTRh20Rkzxq60rgEHuBSk+75pevwPkzpQP5L2Y4tunXIoA514WvMAw6OvMs2M9bAceJXV+b+ncYLQbLjIhca53WqyoknLysASZUVwGUWhfnuMQtm4ttan9vdbOiFv5XaNosCce4Fh/4Se1QYqlF7opuGzZ1A0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787915728; c=relaxed/simple;
	bh=cnkimay18CPk2U6Lsgqz9qn4ga3Cow2v1k1pjNwVqlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3AWR5N3pQonTplXS369S/gQ3y2+j0NmEzb+BQpNeMWc7uKqCR7Y/Ns8faYM1dIC9GKvljdWnCCzDY7qNNO9KF+6Jx+3Oo4ssPK1WhHq60oB1AwSvk/c9QeP4Zs/C6DdxFvwDS4XpKEOrBEJ+Lglee7VOoAXLH+oxPSypXCT78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyCjkeGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyCjkeGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787915726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPxmvC8CiWlce6B63tr6yb12AhzvzWVPgongxbH91Q8=;
	b=ZyCjkeGacS5wPlOPX8GEX2g0ausxyo3tYsBf/dt8cwSUvEd/os2FgJdTV/Qo97A0HqDTJS
	Wujeer8ShkE/KyIqDrBLRD9TouAaldQn1p05QGdmxWA5TgEuJoJqbama2f5zinIAsBWrSH
	rWL0SvfZRGOAmAe1jenqrM5BnIJKYdk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Y6U8eOwhPvuwOrVT0F_2xQ-1; Fri, 28 Aug 2026 07:15:23 -0400
X-MC-Unique: Y6U8eOwhPvuwOrVT0F_2xQ-1
X-Mimecast-MFC-AGG-ID: Y6U8eOwhPvuwOrVT0F_2xQ_1787915722
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c250f2d4b3dso76483266b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 04:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787915722; x=1788520522;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JiYbMpk0QVpG/Nje5Dzxc8mrDMjzdoKIdpT4mZnnljE=;
        b=TFeowd+/P72T/bZWqnqNrHMHx3VOymWq+UScc9WYnb+7kgv0HekzcVuV92K5SUdm4T
         YvkOsprY7ijYLojiJacI3xunDXm5BbkYQYIfPp1VZ+BTWwVwv0bCOveyIVnqlv0mJwDS
         NwsZG3XyDjrAw9RUnw38eDhDrsJuKShe7xhXjzAQbcb2QzV5oqRIWedsnyNQh+hGZj9Z
         2bYggL8qbrkevfT+fBxpk4pxOO4lE3PnwXJEVlM+IarP3RaYmHOA3OUoDh+uSgNpcvV3
         rrGFXxRVRBVpoNHujEqvBRMAUdLwh63Yd0yqRrvcjHiwBumdyQ6yTRnY1eO74uOghgRn
         5b+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpNfz+CBOkiTlQ/s5Y3A7HrKOxsTaOrvjccUfZmDst3QGEFzAq49IyOQQje2yMO0Yh4vZWzg3LhIVKKJ1NCGPdUxbc=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ8MZt/C2dcanrTDTY3vPotOKY7YzxQnDbTbBv8akoogLAqm/0
	+7W7fQbjOHkn3gRqHmILNTtWf6iLOQBzGEeS8rXff5AJ1dYWmxEyaKwf9GEhIF2uuG/BxhLvkzx
	av3AKeycuWqEpAfERGK2WiyJRXmJ+ZioT0LHoMAZXUCKxJb2iKpr2e2l8F6If6B0ifE7TAnMqjd
	p/xOrjrtQD
X-Gm-Gg: AR+sD10MziFBk8SaBn7CLKHtcTdIwBrNyCjKhGJ07rht2BSVwm8CLKQ7bv3jJGOfINJ
	CXQO1xS8t215iZaoAQFbyw1nJlhtZDFHj0ihW4GGzsTYM7zGLn5zerswRZ0DEX0KpdpWqtPe1y5
	N9JSn5dCyTCz1Q9ba8HDAKuisUA58FtbXeeEEfdFRvnt88rrd2t6Wepk0qs+LTXHIBA/9gBShIy
	G65qyk/SuvVxydtIjhnR8gGraTQePylhBB5ARmbalMcIdZ0KY/XlCq0KbVb5Q5A2gD7fo0iRGav
	amZNqPN5ATilv3SNKBpMj9ABw0YDSjWWA+8uqOVI+4L+5JwcxjUv8exzRcbeOlVD8LRfEiTGp5d
	FLL99HFNmKC/O/R8LuJYYibtHD1BE9q5C2Tx5DnQTRvBoIInIMSqzaElJk6oxyE1TiaS8CA==
X-Received: by 2002:a17:906:6a05:b0:c25:608d:7934 with SMTP id a640c23a62f3a-c25608d8c6bmr229059066b.12.1787915722184;
        Fri, 28 Aug 2026 04:15:22 -0700 (PDT)
X-Received: by 2002:a17:906:6a05:b0:c25:608d:7934 with SMTP id a640c23a62f3a-c25608d8c6bmr229053966b.12.1787915721760;
        Fri, 28 Aug 2026 04:15:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2917sm68343466b.30.2026.08.28.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:15:21 -0700 (PDT)
Message-ID: <3aafaa66c21e035879254d4b1c08826bfc70b009.camel@redhat.com>
Subject: Re: [PATCH v6 4/9] rv: Fix ha_invariant_passed_ns silent bypass of
 invariant check
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 13:15:19 +0200
In-Reply-To: <b12480afcae971936571d9c0def64d3a8fa0be99.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <b12480afcae971936571d9c0def64d3a8fa0be99.1787243842.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sbzd37BMiyLFkSOGjo4TZXWyMRVR0zD2QB3OYiyVl4w_1787915722
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> When env_store is U64_MAX (its initial sentinel value),
> ha_invariant_passed_ns() returns 0 immediately without initializing
> env_store to the current clock.=C2=A0 Subsequent calls to
> ha_check_invariant_ns() then find env_store still at U64_MAX, causing
> the elapsed comparison to wrap and always report the invariant as
> satisfied, silently masking any violations.
>=20
> Fix by calling ha_reset_clk_ns() to establish the guard on the first
> invocation instead of returning early.=C2=A0 Apply the same fix to
> ha_invariant_passed_jiffy().
>=20
> This is a stopgap: once the RV framework reworks the per-env clock
> guard, this first-invocation reset should be subsumed.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

I would like to solve this a bit differently. I have this patch hanging aro=
und
to reset() when the monitor starts, which makes the whole invalid thing
obsolete.

I was planning on sending it together with other changes when I have time t=
o
test them, but it seems the patch works fine on this series as well.

I reverted your fix, applied that and added the ha_reset_env() which you we=
re
not defining:

diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
b/kernel/trace/rv/monitors/tlob/tlob.c
index 18150cbf57a5..934eea34021a 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -175,6 +175,12 @@ static u64 ha_get_env(struct ha_monitor *ha_mon, enum
envs_tlob env,
        return ENV_INVALID_VALUE;
 }
=20
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_tlob env, u6=
4
time_ns)
+{
+       if (env =3D=3D clk_elapsed_tlob)
+               ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
 /*
  * Invariant: clk_elapsed < BUDGET_NS in running/waiting/sleeping.  "stopp=
ed"
  * is exempt: the parked period must not be measured against the old windo=
w's

---

Applying the appended patch too and running the selftests seems to work fin=
e on
my setup.

If you want, you can add this patch to your series for now as it doesn't ha=
ve
dependencies, I can sort the rest out.

Thanks,
Gabriele

---

From 29bdf58fc8f108d63b06051b415b97a45b27a976 Mon Sep 17 00:00:00 2001
From: Gabriele Monaco <gmonaco@redhat.com>
Date: Mon, 25 May 2026 10:23:25 +0200
Subject: [PATCH] rv: Force environment reset action on HA monitor start

Currently the monitor variables with a storage (e.g. clocks) are
initialised as invalid, then the first explicit reset() sets them as
valid for constraint. This only adds extra complexity to handle the
invalid case in constraints check.

Apply a reset() by default when starting monitors instead of resetting
to an invalid state. If monitors have no stored variable (hence no reset
function) add a macro HA_NO_RESET to stub it, this is all transparently
handled by rvgen.

The reset() action on ns-granularity clocks needs the (possibly cached)
current time, read it directly there. This might cause a double call to
ktime_get_ns() within the same da_handle_start_run_event() but will
occur only the first time and is harmless.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ha_monitor.h                 | 8 +++++++-
 kernel/trace/rv/monitors/opid/opid.h    | 1 +
 tools/verification/rvgen/rvgen/dot2c.py | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index c2e200234e67..4fc5dadb4240 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -167,19 +167,25 @@ static void ha_monitor_destroy(void)
=20
 /* Should be supplied by the monitor */
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_n=
s);
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 tim=
e_ns);
 static bool ha_verify_constraint(struct ha_monitor *ha_mon,
 =09=09=09=09 enum states curr_state,
 =09=09=09=09 enum events event,
 =09=09=09=09 enum states next_state,
 =09=09=09=09 u64 time_ns);
+#ifdef HA_NO_RESET
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 tim=
e_ns) { }
+#endif
=20
 /*
  * ha_monitor_reset_all_stored - reset all environment variables in the mo=
nitor
  */
 static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
 {
+=09u64 time_ns =3D ha_get_ns();
+
 =09for (int i =3D 0; i < ENV_MAX_STORED; i++)
-=09=09WRITE_ONCE(ha_mon->env_store[i], ENV_INVALID_VALUE);
+=09=09ha_reset_env(ha_mon, i, time_ns);
 }
=20
 /*
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitor=
s/opid/opid.h
index fb0aa4c28aa6..f85b1959c2fb 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -28,6 +28,7 @@ enum envs_opid {
 };
=20
 _Static_assert(env_max_stored_opid <=3D MAX_HA_ENV_LEN, "Not enough slots"=
);
+#define HA_NO_RESET
=20
 struct automaton_opid {
 =09char *state_names[state_max_opid];
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/r=
vgen/rvgen/dot2c.py
index 22938ce1bf6c..1532e6b6e199 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -90,6 +90,8 @@ class Dot2c(Automata):
                         ' "Not enough slots");')
             if {"ns", "us", "ms", "s"}.intersection(self.env_types.values(=
)):
                 buff.append("#define HA_CLK_NS")
+            if len(self.env_stored) =3D=3D 0:
+                buff.append("#define HA_NO_RESET")
             buff.append("")
         return buff
=20
--=20
2.55.0

