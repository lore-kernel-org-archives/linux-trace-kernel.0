Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632173DB97A;
	Mon, 20 Jul 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544218; cv=none; b=s1tStsubVDeJy0jK+mGea9m8gv78aMYNu764PQ5XpdX8dOWuKQDb3bgwcL5oExulyWeCDSHE2IzP/R27YvN454osTIkgmn0BP0147U57X2DGusWCLOXL+KuSsGWVmU87C6ksJ8zKk38gT4AXKMY8t08tE7mMUTenmOSD7W4qrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544218; c=relaxed/simple;
	bh=TQTr1wxDrReqHvbmZRcWzcYBfENDoNz/qajfsSJa8Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VG29mevmptlx5hP6ESbPT+s1bIzQdfaMb0FMwAFp7zEEA1t5pMPgxcIvLRsiKO0TlDuWcjDbiS1dIIfOO1iBkX9iKrmtE4hics/hXP0OVSkUcgQaKlavmQaUe81dDw3d1AlpW2wVgd1UxHKtVlh23nesePpPrtKU3Lw9bv/9rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btCM9oW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btCM9oW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70F1F00A3A;
	Mon, 20 Jul 2026 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544213;
	bh=jdIVIuHefzHmk8bd1w1jUdAVEUQlPpJqTG6Is3b/RFI=;
	h=From:To:Cc:Subject:Date;
	b=btCM9oW9W/fuJjut2IXSUV36b6W3C1MtGrRcLAm/RisPyKbwL/hN67xJqJfp6kwi9
	 9u6T1A5i4tEmOt4Q3Xj+lXJN3Bx+k3LLza9D5rVMSWYUhQOQ6K5lziqnA8Z69FI4dK
	 ALt0BF2BK0TAafViAPsITL7b3RdnCduKFegPrMmKo/YWB444WCM6LOIUYFSkYK7PD5
	 3JfV5ChR5vZaM1234hu+jMOSB3n/8Ur/xkAmvH9gh+iRGjq/LaunyW0hyuw8/p69PN
	 otJIjZh8n2qC9YL0I704KRd4zru2jSqZk02e9zOHNZJf3yG0NvbFWK7RQjocDXF1Zp
	 WbURAcv1cE8tw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 00/10] tracing/probes: Cleanup probe event code
Date: Mon, 20 Jul 2026 19:43:30 +0900
Message-ID: <178454420994.296567.10239174745865301350.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are a patches to cleanup the probe events related code
(kernel/trace/trace_*probe*).

Thank you,

---
base-commit: 1a416ae446afa42d2d8500ce25bd61c564508721

Masami Hiramatsu (Google) (10):
      tracing/probes: Remove duplicate MAX_ARRAY_LEN macro definition
      tracing/probes: Remove redundant boolean conversion in trace_probe_has_single_file()
      tracing/probes: Remove redundant bounds check in trace_probe_compare_arg_type()
      tracing/probes: Remove unused parameter from parse_probe_var_retval()
      tracing/probes: Cleanup pointer arithmetic in store_trace_entry_data()
      tracing/probes: Simplify BTF_KIND_PTR case in fetch_type_from_btf_type()
      tracing/fprobe: Remove redundant snprintf in trace_fprobe_match_command_head()
      tracing/fprobe: Remove redundant memset in fentry_perf_func()
      tracing/kprobe: Remove redundant memset in kprobe_perf_func()
      tracing/probes: Fix extra whitespace in trace_probe_kernel.h


 kernel/trace/trace_fprobe.c       |    6 +-----
 kernel/trace/trace_kprobe.c       |    1 -
 kernel/trace/trace_probe.c        |   18 +++++++-----------
 kernel/trace/trace_probe.h        |    3 +--
 kernel/trace/trace_probe_kernel.h |    2 +-
 5 files changed, 10 insertions(+), 20 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
