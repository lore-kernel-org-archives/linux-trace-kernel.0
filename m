Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89D1B7FD;
	Mon, 10 Jun 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054790; cv=none; b=H48xrVcEkLr5Tm12Tl/j6Ab4tWimtls2I6Lig6LN+yzIBfhAz1OWQsNafHpgvZa33I20dNfK3xluZo1di9PDuxPjyVCoqyfjzl4NRRKjsV90t55y9Nb7A5ClWpPq/i5G5GHm9jJz9Xg5YDL4mHoVu9jLHiqtk1hgF48qC7er3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054790; c=relaxed/simple;
	bh=I9dQxF7evrDdKUiLRYHLxwMlUHRxYsTQCbEh4GfJZEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J5xs1ZLD35ujf5FPz0NEgjFEDM3dkxJngWQOisfGsq3v/v86nuKpQQXF04Q508STNOuVa1gPuYQmRg0QjrgTjzSHtTuiZZ2Aat6dCvU4xS/I9Af480HDetVTGnxmSl5DPxDc/KFXljVH2U0WCvPzDiY3zlnV1XpH9iMsym57B2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz4G6WvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz4G6WvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16008C2BBFC;
	Mon, 10 Jun 2024 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718054789;
	bh=I9dQxF7evrDdKUiLRYHLxwMlUHRxYsTQCbEh4GfJZEY=;
	h=From:To:Cc:Subject:Date:From;
	b=Wz4G6WvStABHFDrBUDRnd/8naxNlazFGFIY1Cjcyrihp4qe8xKMkS8evxk6NQZ6ar
	 nvpeg6Sc1CqbH8ef9BFwou7byuX/pQmXXDsG1YlLsbZJBF5k8IX2uRFFD2/rRZ+f2Q
	 m1sdd7oJC/0FV7nUkKTeoF/ZpAPq87BiBJyNtR4O7y4HmT3PXX9pRQrK1EJIUoQklv
	 0VqthTfrCQvc51e+MOlSFsi2x8Mj7/R3qN6jTxBcvuc2Y2JQsKetFFIDFR/Ed6wU9X
	 EBZk6XlOH7NGO+dh0yMCEDlMAG/AYgoQUzFbZl02N9gQVKbB9MK7v+q5k2E9KbQeYI
	 k2YkrxvGGFfig==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/3] tracing: Fix some selftest issues
Date: Tue, 11 Jun 2024 06:26:25 +0900
Message-Id: <171805478534.52471.6269290579314514778.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Here is v2 of a series of some fixes/cleanups for the test modules and
boot time selftest of kprobe events. The previous version is here;

https://lore.kernel.org/all/171671825710.39694.6859036369216249956.stgit@devnote2/

In this version, I just update the description of the first patch to add
what bad things happen when the modules are built in.

I found a WARNING message with some boot time selftest configuration, which
came from the combination of embedded kprobe generate API tests module and
ftrace boot-time selftest. Since kprobe and synthetic event generation API
test modules add new events and lock it. Thus dynamic event remove-all
operation failes. This also causes all ftracetest failed because it tries
to cleanup all dynamic events before running test cases.

The main problem is that these modules should not be built-in. But I also
think this WARNING message is useless (because there are warning messages
already) and the cleanup code is redundant. This series fixes those issues.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing: Build event generation tests only as modules
      tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
      tracing/kprobe: Remove cleanup code unrelated to selftest


 kernel/trace/Kconfig        |    4 ++--
 kernel/trace/trace_kprobe.c |   29 ++++++++++++-----------------
 2 files changed, 14 insertions(+), 19 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
