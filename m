Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3B3DDB11
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643959; cv=none; b=R9MQolA4H/M/vivZBIKOMKSSplUYwSyt32CkwzE+ZmNejhmNu/SxDxu5vweRXduskLZO1VPgo0BDPf7dXXzy7FAKK5QDHJ7giS8b3B2kiavj6ty4l0YUlFGD+3Ui9MWYiHeZm0p7Gu6YXHFu1wvm8EDh8S5Dy3ZD1VTEP6vJD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643959; c=relaxed/simple;
	bh=b5bThAG7m3eD8Y62kiDvFrc7t16AsIOBsarbuR0+kiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXQZPOPbjGFaO73ZtRlTr18xD75cmIdEws/Xcp804AxoCpXIrBE1Pvhs6JMywS/XGtDR9Kc6zqTePXuRdcajyhSOJgIZYJTng6/5YAgOEP27qo9ICRz9QX6XvnZJGlwLavjzmTXlKiB3xKbCgeLpY0OBJ8QAfgwWSePx8fX2Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrmLUtA3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrmLUtA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786643949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s70CnKVp3XoOu5s78rqLNBtuOZIHcEqbx60rXlfoiM0=;
	b=PrmLUtA3QIZ9gCcDu3xP4tvg4B4kWei800QYkMZEBSpfMTn7plS3HpT1qfrqjNMs1q7P7Z
	1fHkW3xGTaYTVcWQm1lyVEiBM9AfDCq5mJxrCBwS+xe/ANI61YCG1RUv3Mvco9ibLpwucj
	GqLRjvozx87VRSvPlNUtVk4v8M3ANbI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-RSm-GCV1N7iIp1-Jl6MFeA-1; Thu, 13 Aug 2026 13:59:03 -0400
X-MC-Unique: RSm-GCV1N7iIp1-Jl6MFeA-1
X-Mimecast-MFC-AGG-ID: RSm-GCV1N7iIp1-Jl6MFeA_1786643942
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83450a8eso95502f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643942; x=1787248742;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cn+ZciJ4T+P3W9rLIenYBjYgeAAESRCXCkOi/qausXM=;
        b=YGTACoxmpK6YlQ5D9JhqmqLXvvJ2RwQsblOlNCn+dz1rDdRcehxSM1VPIDlwtPjh1p
         IJActNojmWPavhnVD23Ud4UMbnrGHTyR6KafQvHlhx8FzBZPMlpeFWL6mDriqjxPp2Im
         PeBWU/uRO6ve+WcTuU3rWI8UlLlLAcRKJhY9HtQxKqYqkJ6gO4gtui/A6hsP5A9WW1yj
         WdzG/pySbGTUgOPaXoc+5LbN9jIUp0rQHKeIU67wcqsuSPp5vh5jiPqxCVNtuwRU/xbr
         t1tCrJZDmzZLlu1F7g26BWxkfA1yhfvGcPZgVOwmpzgqN8qdLVdP4bycFoyZKErraIVi
         pzvA==
X-Forwarded-Encrypted: i=1; AHgh+RpBHGsGkG0mpLIMMwol+4BW2hUWe7AqTFA9L1hRb118hP+wXw6VBW5Ec1/uC2QsDTSbK+4edSodX0kpqJrfce2V2go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCcNzYp1OCGSAwBJpDAJVuA2ILByIoAAPt7EK5Ab2KabH4XxF
	t/QJeZd5jP2XViZ9IFu1nBV8I0qQ+gImonGSE3+quzKufagM0vd3m/JClIbH4f233MR1xaYGie/
	D+/k+KGbN3jZIwtCFGHep+tlUpRpwEk1EospptPTh4aWoX5KYnNrbZu9T4aFCNWeg+R8pjQO1GA
	==
X-Gm-Gg: AR+sD13MzXaJ56TntZrsRmmy7r7u7BS4L6TDlCA/N90Rv8NWcf/BJHBq4Axvq92bS5U
	8eKVQ7TnbM/zoaboietrPPpZVlSM5EiN9iGIe9Bw6pzWRunybXCV6Bi7j83w6s0RRKy8m7R7pdr
	0fWmRN4zAM8SNZLSAJjjxd46DqQkBfpT86GQaK1YYkQnd0Eo78Ss9Q/y3mKVFUl5nGVZldqfVkB
	sLxwQHj/sW/MShAWug6vDNcPWEPtiVgc5vwyhNGqdAqpLeBfVdZwDZ2z2Z6rv+1cc3avwd6Z/2D
	yo3x7W2gBcMo2Pmna01fcptSKDZ4bfBYHXepOgWymNTAl/et/3No9A6Nyb0/WxX4/dzT/nuoSkj
	iR8oV9DI/R6LUrm+2YkYUsw4MNKjqoV5dmXPJNKb9yLBgsv9RYrXuemiWROBaVA==
X-Received: by 2002:a05:6000:260c:b0:47f:97e9:fe60 with SMTP id ffacd0b85a97d-481607540e2mr31121f8f.15.1786643942390;
        Thu, 13 Aug 2026 10:59:02 -0700 (PDT)
X-Received: by 2002:a05:6000:260c:b0:47f:97e9:fe60 with SMTP id ffacd0b85a97d-481607540e2mr31072f8f.15.1786643942007;
        Thu, 13 Aug 2026 10:59:02 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm1160667f8f.6.2026.08.13.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:59:01 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 5/6] rtla: Unconditionally clean any pre-existing
 filters for user-provided events
In-Reply-To: <CAP4=nvSafV3qasrKjVfZQsTcKzeMCsNKdF0KMpNpzkbHM28iLQ@mail.gmail.com>
References: <20260804174242.2288433-1-vschneid@redhat.com>
 <20260804174242.2288433-6-vschneid@redhat.com>
 <CAP4=nvSafV3qasrKjVfZQsTcKzeMCsNKdF0KMpNpzkbHM28iLQ@mail.gmail.com>
Date: Thu, 13 Aug 2026 19:59:00 +0200
Message-ID: <xhsmho6f57vh7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tsLEZQFWi0ymbMf6Z9dZC6K-hwQM5ezHLSfef6f9fLg_1786643942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/08/26 13:24, Tomas Glozar wrote:
> =C3=BAt 4. 8. 2026 v 19:43 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>>
>> A later commit will apply a filter to events recorded to the trace
>> output. To prevent any user confusion, remove pre-existing filters when
>> enabling an event provided via the '-e' command line argument.
>>
>> Suggested-by: Tomas Glozar <tglozar@redhat.com>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>
> I found that I missed one case when suggesting this: the user might
> supply an event twice. With this change, it will now clear the filter
> the second time the event is applied:
>
> $ rtla timerlat hist --no-aa --on-threshold trace \
>     --on-threshold shell,command=3D"grep sched_switch timerlat_trace.txt
> | grep -Fv '[000]' | head -n1" \
>     -i 1 -e sched:sched_switch -e sched:sched_switch --filter "cpu =3D=3D=
 0"
>
> Without this commit:
>
> ```
>  Saving trace to timerlat_trace.txt
> # RTLA timerlat histogram
> ...
> ```
>
> With this commit:
>
> ```
>  Saving trace to timerlat_trace.txt
>          <idle>-0       [002] d..2. 423185.347008: sched_switch: ...
> # RTLA timerlat histogram
> ...
> ```
>
> (Note that events are processed in opposite order to the command line.)
>
> This is unexpected and might break scripts that for some reason enable
> an event twice. So I'm not sure if my suggestion was the best
> solution.
>

Hm, didn't think of that.

I would say having the last defined event+filter override any previous
filter would make the most sense.

trace-cmd does this partially:

bash-5.3# trace-cmd record -e sched_switch -f 'CPU=3D=3D0' -e sched_switch =
-- bash -c 'ls &>/dev/null'
CPU0 data recorded at offset=3D0x180000
    109 bytes in size (8192 uncompressed)
CPU1 data recorded at offset=3D0x181000
    0 bytes in size (0 uncompressed)
CPU2 data recorded at offset=3D0x181000
    0 bytes in size (0 uncompressed)
CPU3 data recorded at offset=3D0x181000
    0 bytes in size (0 uncompressed)

bash-5.3# trace-cmd record -e sched_switch -f 'CPU=3D=3D0' -e sched_switch =
-f 'CPU=3D=3D1' -- bash -c 'ls &>/dev/null'
CPU0 data recorded at offset=3D0x180000
    0 bytes in size (0 uncompressed)
CPU1 data recorded at offset=3D0x180000
    1428 bytes in size (237568 uncompressed)
CPU2 data recorded at offset=3D0x181000
    0 bytes in size (0 uncompressed)
CPU3 data recorded at offset=3D0x181000
    0 bytes in size (0 uncompressed)

Although I didn't realize that events were handled in reverse cmdline input
order until you pointed it out.

AIUI filers and triggers rely on the LIFO ordering to grab the
last-provided event; making the events list double-linked (but not
circular) would let us process them in FIFO order; something like the
barely tested:

---
diff --git a/tools/tracing/rtla/src/cli_p.h b/tools/tracing/rtla/src/cli_p.=
h
index 3c939de9abf02..4638cc317ea26 100644
--- a/tools/tracing/rtla/src/cli_p.h
+++ b/tools/tracing/rtla/src/cli_p.h
@@ -221,8 +221,10 @@ static int opt_event_cb(const struct option *opt, cons=
t char *arg, int unset)
 =09if (!tevent)
 =09=09fatal("Error alloc trace event");
=20
-=09if (*events)
+=09if (*events) {
 =09=09tevent->next =3D *events;
+=09=09(*events)->prev =3D tevent;
+=09}
 =09*events =3D tevent;
=20
 =09return 0;
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.=
c
index e407447773d04..35601a2e8d0c7 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -440,6 +440,18 @@ static void trace_event_disable_trigger(struct trace_i=
nstance *instance,
 =09=09=09tevent->event ? : "*", tevent->trigger);
 }
=20
+static inline struct trace_events *trace_events_tail(struct trace_events *=
tevent)
+{
+=09while (tevent && tevent->next)
+=09=09tevent =3D tevent->next;
+
+=09return tevent;
+}
+
+/* Events are stashed in LIFO order; flip that to FIFO processing */
+#define for_each_trace_event(tevent) \
+=09for (tevent =3D trace_events_tail(tevent); tevent; tevent =3D tevent->p=
rev)
+
 /*
  * trace_events_disable - disable all trace events
  */
@@ -451,7 +463,7 @@ void trace_events_disable(struct trace_instance *instan=
ce,
 =09if (!events)
 =09=09return;
=20
-=09while (tevent) {
+=09for_each_trace_event(tevent) {
 =09=09debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ?=
 : "*");
 =09=09if (tevent->enabled) {
 =09=09=09trace_event_disable_filter(instance, tevent);
@@ -460,7 +472,6 @@ void trace_events_disable(struct trace_instance *instan=
ce,
 =09=09}
=20
 =09=09tevent->enabled =3D 0;
-=09=09tevent =3D tevent->next;
 =09}
 }
=20
@@ -544,7 +555,10 @@ int trace_events_enable(struct trace_instance *instanc=
e,
 =09struct trace_events *tevent =3D events;
 =09int retval;
=20
-=09while (tevent) {
+=09if (!events)
+=09=09return 0;
+
+=09for_each_trace_event(tevent) {
 =09=09debug_msg("Enabling event %s:%s\n", tevent->system, tevent->event ? =
: "*");
 =09=09retval =3D tracefs_event_enable(instance->inst, tevent->system, teve=
nt->event);
 =09=09if (retval < 0) {
@@ -562,7 +576,6 @@ int trace_events_enable(struct trace_instance *instance=
,
 =09=09=09return 1;
=20
 =09=09tevent->enabled =3D 1;
-=09=09tevent =3D tevent->next;
 =09}
=20
 =09return 0;
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.=
h
index 95b911a2228b2..eacafc0c96b31 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -4,6 +4,7 @@
=20
 struct trace_events {
 =09struct trace_events *next;
+=09struct trace_events *prev;
 =09char *system;
 =09char *event;
 =09char *filter;

