Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF93EFD15
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416760; cv=none; b=g7U1wWeCkxbxtwn1/FD9un5vYI8Z64OIZaFnnIbQ6/0lus7nD5ZKZYzvQPrAa7iwrupTCn7GJHKqsoUL4nnLrVorgZ08ih+qDigKAyxHBm/bU899LkAW29MHOCgLjYuqsdHSbm+WGlfQC7k6bz09AWFpodmGOrokDd7cOQnEiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416760; c=relaxed/simple;
	bh=jsVIcmcV6g+wiQNa9nON043q6Oo5ERD1DmYjyVTfa/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHPY2FQDu+okYlVyd3y6YnBufswhyxPAcVJWP/hDNyWyUMfPgQCYHJTnKfzBJwqlnoIYK3edBKVGoK9el/GmPw6U9r/8A7Nd9Iz9LWkZlFv7xyP3LVm/w53n4iG3iofpGqfi3FHQ4rWYGa0Qc5OLkoV0qojTDIy98MQKxZ7cRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNBe8FGF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNBe8FGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780416757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
	b=aNBe8FGFyz4ISSzXgVFtXqn3LhvN3fYYk/wLYNpSC8Ko3okIJdftxPWxwomaBDme+/zp53
	J+pFFSzaMvYNmSuHwvlAZQxZZxdlWCDX9tOo4tdhsM88oWIxaz8jvipIAv0yg3CgJJZ25p
	hBFU9ykZU9GjvSajB6XM0frXkJqlTXA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Xf1QAVFuPGCm7d6REQP5ww-1; Tue, 02 Jun 2026 12:12:36 -0400
X-MC-Unique: Xf1QAVFuPGCm7d6REQP5ww-1
X-Mimecast-MFC-AGG-ID: Xf1QAVFuPGCm7d6REQP5ww_1780416754
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-396aafb07c6so1329871fa.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 09:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416754; x=1781021554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
        b=NMDa89hGs5rL0AIehnxEziTe4JYfPTqD9ZZr6ALLx2/6t8LdHmyPsoBl/mE5kocgr9
         SSx98OxFHHhAfoZapTtD7rDjoQnNToeOf+3X0YuePi5UImMIcUIlVGXkuIzo92KhIlng
         VhR6rsgq3QbP/YPKSjUaqdIRtSmmDh7T7YY1S6Az48jynBXu4XG3hVLZNdG9JIkjOFfS
         +Sgo0CQo7aoQZNkoJn8ZIdJ3UP1S1XxLI21F5A4GS+2/u8v3Erq/E8hEXMomU0oIndOF
         Ktv9vrv8+NbrFEe1LfkEj+q2ZrhyLYQ8W+zfIa/VRXn5xxfQfXF2D5FKJbJd/LFQv83u
         m/LA==
X-Forwarded-Encrypted: i=1; AFNElJ+uWduFYhN2yxlsFlC0dBeor7pDJj9lWLJiA1NdqjZ35X47lr5sA+yj+4ihh0zakh5ikwe9t8XwM4so9hqWQA6yPbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUBly3ZVZFtkAXq3pUaNxM5qyJh12FoipIQ35VZsUPyDZ+GBq
	hnm2P9k5V1mL/UUlKtBIQA+uvHn3mlL2ZJS9ltVEPhnaDOfd3dmXKgwd2vPyF/Q0V7oVZobPDw1
	b7CWldEcugG4KWJKV03o3MNocdrVcypWBLmo93/l7FI0IK4vJtPlhg48lRa5F5kIVGNJFpUGGD4
	nnRF+jcUV2HTCgCy9M0NZkGKkd47Ygb5P9qiaw6msx98/bsOcO
X-Gm-Gg: Acq92OHaSItd36slDglEW0U72stX7ZybZfhR+jBPYCoCcWi7hM+ckqlgOjEw4YzSDMi
	813TOzjDOiY6Dvy/Np9IiXAm7D83WM5bR3kRw323hbsipEck2Jg/rOLUKOzXlX6HFUKr4Nm0dJM
	Av+EPl0HsMSptAso6dGFyGuDvSif9oUFKBu3or8F4wrRI2lnQzqAb13dGMPinmj9RyfyXvw7xmS
	a7BFq8h98ZAHKhht9B85on/G+o9Hq2gfA2su49ZBAcY7NHzFnU=
X-Received: by 2002:a2e:9a13:0:b0:393:82e9:fb63 with SMTP id 38308e7fff4ca-396ac26058emr1399971fa.1.1780416753993;
        Tue, 02 Jun 2026 09:12:33 -0700 (PDT)
X-Received: by 2002:a2e:9a13:0:b0:393:82e9:fb63 with SMTP id
 38308e7fff4ca-396ac26058emr1399811fa.1.1780416753576; Tue, 02 Jun 2026
 09:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515194010.93725-2-ashelat@redhat.com> <20260515194010.93725-4-ashelat@redhat.com>
 <20260518214116.GZ3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260518214116.GZ3102624@noisy.programming.kicks-ass.net>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Tue, 2 Jun 2026 12:12:21 -0400
X-Gm-Features: AVHnY4ImP7GIhTl8MEnOUlfsCdz6wMiKYij0lm6-i55yCrS9sEILvfi1RchCDE4
Message-ID: <CA+G8DhL78GE-1OigkF++aw-CmFzHkbeU5b8JbZ-ymswRfaEt+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf: enable unprivileged syscall tracing with
 perf trace
To: Peter Zijlstra <peterz@infradead.org>
Cc: mpetlan@redhat.com, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aho4l7oh1wNG4Vs2vcaA12noEpX9UJCLCKEjg-TBXu4_1780416754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:41=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Typically patches are supposed to a single thing, you're listing 4
> things. What gives?
All four changes need to be made together to work properly. The second
point could be pulled out as a separate patch, but will be replaced
with the eventfs that Steve suggested. The other three points
represent a single logical change: selectively loosening the
perf_event_open() restrictions without exposing kernel data or
breaking uprobe functionality.

> PERF_SAMPLE_IP should be here too, no?
If PERF_SAMPLE_IP is added to the kaddr_leak mask it blocks uprobes,
so the PERF_SAMPLE_IP check is in the trace_event_perf.c changes where
I can exempt uprobes:
+       if ((p_event->attr.sample_type & PERF_SAMPLE_IP) &&
+           !p_event->attr.exclude_kernel &&
+           !(tp_event->flags & TRACE_EVENT_FL_UPROBE) &&
+           sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+               return -EACCES;

> And I'm not sure if tracepoints can trigger it, but PHYS_ADDR also seems
> something we shouldn't allow.
There's a check for unprivileged access to PHYS_ADDR at core.c:13917
so I didn't add it to kaddr_leak.

> And we're sure RAW doesn't include pointers
PERF_SAMPLE_RAW for TRACE_EVENT_FL_CAP_ANY tracepoints doesn't include
kernel pointers.

> Again, you're doing the same thing in multiple places. If only there was
> something to re-use a previous expression.
>
> None of this gives me warm and fuzzy feelings.
You're right. I'll factor the checks out for the next version.

Anubhav

