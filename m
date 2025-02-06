Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74021E0B7
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Feb 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842446; cv=none; b=JJ96Qc+OYzRYUYI0GEcYc5o28gP/hwoI4TWQa6CwGPEt0bUHhMPLpZiuwxGEXECqQ3HARXx7/XZWKvFy3ocrfsSxV6Cz5obYK3Vw8nipmg80NqOmDfZvLTHlqTr6aGDON4CwMFvSr4Vxbxgzac4GVa8Q7YSHF+TsGIdynrYFuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842446; c=relaxed/simple;
	bh=a/Xm8aj2vlhSlJllO3PWBXvZn+46e9ONno+fbb6e1bM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEHySXVZiYG9DMkR3je+F/UHm7VJI25+c+SJ1/rvKmvIH56z8yAgwj85xtQi9EZRJVccLFdxPF6Od5FierfDhuXYMFGzWEGtLgAj7oZZM7q0QMgxZDiSuEvgdT+g2o6ojvFtrAz4+rKIOv7xc+9HvS8QH4jaQC17jIwLKR4nx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAxrgKvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAxrgKvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738842443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fSAkfRkQPvRxFNFTaRJCBDO2IC+tb40TSBtMJR0fb5g=;
	b=aAxrgKvEpDupG4RjLYkDEkunffzx+a0leM3I9ESRLzWSIYhCnqnbEnQ5hbAbtr9+859BWv
	8EMjQm/L93XDcp8C/bLHJtoYPqBmSF81ltBOMVQq2TmgXhZn43uIU6AquwzUt4Otrw+cOE
	PXe6Qkf1mKBJcuY4LvV1SyxM91qDOpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7pkHl_JYM4CDICz5q6bwvg-1; Thu, 06 Feb 2025 06:47:22 -0500
X-MC-Unique: 7pkHl_JYM4CDICz5q6bwvg-1
X-Mimecast-MFC-AGG-ID: 7pkHl_JYM4CDICz5q6bwvg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so6602455e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Feb 2025 03:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738842441; x=1739447241;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy2FKCeBq1SU957TE4mxB3MK1uzhlMiHCxjSG5afeJI=;
        b=VbmaKNUDBWW/ABHyTW4IUamHR46EBP1mw99C8MBoSSmr1Zagoh57xVikqcJyEyLVOH
         7CNky2AI4d8QiRLWxNXHyKd1Sbl9fz4FdoWHSGiK7VGTs3YXRcQsd006KcO1yWpaZrWF
         /clQ7fXd0tA/pOzvawxFpqhJTBn+PJg33f5bR+9W6O86JU4bXwJ2yopOh0bMBpal+jaY
         yNIrkeL/uy2qhS82QaeWxXfTiAJ+EZvIUtl3qa5gEYNFyHi0AJ59m5roNtKN4AKoVcfJ
         U6WMx/s0099KWQ2nsIKXB4lhHRybTKrkH1cDXAc9c3aj69Hf6Z+9Rwjwx583GWIActCq
         slHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/i2EbXqzmlezW/t4zVZjzVnQbcG1RKMF4Txs1yNKnBcWZip20+uDEG1DUrEtVYXrMg/TJJVDtxsvNbdBLKcC4ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSd2XeNgokf07ZNCZDr/yJF30VMnbM2D8cD6hsrxbUjKjreAe
	b4eziHjnTaOcKxPEwuw2qEgUB19BnFpYWcS7wmBMYTFTpJBrt+edKWylR6Kd7Yv/netP3ejbFs7
	+Idvs5iXu5XLoh35Mb7+pZDK7EI1Rvp1AW6dys+FPCp7xp5BW5xt4cauAuoZ1K9ckLpPtdw==
X-Gm-Gg: ASbGncscnF5SCsW7qfXQ4pRtmB7tbi4rmNrSUuNchRIE6W6F4SNN5IMXcAtHsszdwe9
	wHfHSb0KJJBUASouOaiq7O5Y5rn1LaNIMhgDKW08pB76GkhgT4o0QW85yEQ+c/9E60pR/2cWGzz
	EgUpPSIh3Yp9D+wmhRQP2H1n5o9P6VC2S6XA9/M/jUf5PvGk+Yds08EuEBExDyZibvHs8uDC5zg
	rKmKfXlcddKARgs4/U29B8cZEZZunQViJSxzIwvXlbwUpNYVDqc3HqZIl5MVkf1Gb4aoOPYjHUB
	d6Zh87IBCFhtedEpl14ondxFu6b5zD4=
X-Received: by 2002:a05:600c:4586:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-4390d43e90emr76244595e9.16.1738842440792;
        Thu, 06 Feb 2025 03:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIZzkUxVZHwTwp/9vlaB//pSPOdWyQfr606Hz2/0/dN8YRTYL7OQ4AmFikgXi+GNq+gARynw==
X-Received: by 2002:a05:600c:4586:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-4390d43e90emr76244265e9.16.1738842440442;
        Thu, 06 Feb 2025 03:47:20 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde31e09sm1537030f8f.99.2025.02.06.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:47:20 -0800 (PST)
Message-ID: <1818165c4cbaedfb7314f4a200a273454ce49b63.camel@redhat.com>
Subject: Re: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 12:47:17 +0100
In-Reply-To: <20250206085738.GL7145@noisy.programming.kicks-ass.net>
References: <20250206080952.98478-1-gmonaco@redhat.com>
	 <20250206080952.98478-4-gmonaco@redhat.com>
	 <20250206081942.GJ7145@noisy.programming.kicks-ass.net>
	 <d8187fcd53c62272d7e1a8dad327c4f2a5f07188.camel@redhat.com>
	 <20250206085738.GL7145@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3R0jd8n-_EiwBY6PRqJoc6ESMgR-liRGrfUx7C3m4l8_1738842441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-06 at 09:57 +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 09:36:41AM +0100, Gabriele Monaco wrote:
>=20
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 165c90ba64ea9..fb5f8aa61ef5d 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -491,6 +491,12 @@ sched_core_dequeue(struct rq *rq, struct
> > > > task_struct *p, int flags) { }
> > > > =C2=A0
> > > > =C2=A0#endif /* CONFIG_SCHED_CORE */
> > > > =C2=A0
> > > > +void trace_set_current_state(int state_value)
> > > > +{
> > > > +=09trace_sched_set_state_tp(current, current->__state,
> > > > state_value);
> > > > +}
> > > > +EXPORT_SYMBOL(trace_set_current_state);
> > >=20
> > > Urgh, why !?!
> >=20
> > What do you think would be better?
>=20
> So I would think having the tracepoint in-line would be better.
> Because
> as is, everything gets to have this pointless CALL to an empty
> function.
>=20
> If this were x86_64 only, I would suggest using static_call(), but
> barring that, the static_branch() already in the tracepoint is the
> best
> we can do.
>=20

Ok, I see your point now..

Adding the trace_ call inline seems far from trivial to me, but we
could indeed do what's suggested in tracepoint-defs.h and practically
use a static branch to call this trace_set_current_state, not sure if
this is already what you were suggesting, though.

Ignore the inconsistent naming, but something like this should work:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index af9fa18035c7..7b9d84dbc2f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -223,6 +223,12 @@ struct user_event_mm;
  *
  * Also see the comments of try_to_wake_up().
  */
+
+#define trace_set_current_state(state_value) do { \
+=09if (tracepoint_enabled(sched_set_state_tp))   \
+=09=09do_trace_set_current_state(state_value); \
+} while(0)
+
 #define __set_current_state(state_value)=09=09=09=09\
 =09do {=09=09=09=09=09=09=09=09\
 =09=09debug_normal_state_change((state_value));=09=09\
@@ -332,7 +338,9 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
=20
-extern void trace_set_current_state(int state_value);
+#include <linux/tracepoint-defs.h>
+DECLARE_TRACEPOINT(sched_set_state_tp);
+extern void do_trace_set_current_state(int state_value);
=20
 /**
  * struct prev_cputime - snapshot of system and user cputime
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 149d55195532..9fc2be079bb5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -491,11 +491,12 @@ sched_core_dequeue(struct rq *rq, struct task_struct =
*p, int flags) { }
=20
 #endif /* CONFIG_SCHED_CORE */
=20
-void trace_set_current_state(int state_value)
+void do_trace_set_current_state(int state_value)
 {
 =09trace_sched_set_state_tp(current, current->__state, state_value);
 }
-EXPORT_SYMBOL(trace_set_current_state);
+EXPORT_SYMBOL(do_trace_set_current_state);
+EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
=20
 /*
  * Serialization rules:


