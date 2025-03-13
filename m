Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BD8633F;
	Thu, 13 Mar 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883206; cv=none; b=Ok9NFY4nJnU/5r9bYhjyYeT2mpv389AmvJPeoNpLAbX/qYSNYoDdqWYUOcaa1vRPXtiOubOPhNST1KPlVTgHdrLU4aq2hXB45q1ZWXrmP2YsOcrv4suYsAVMF+xWQHI/wh+M++EfA2ss10Dw+iuGM7TwjOdCjmuDiEJc8EaRMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883206; c=relaxed/simple;
	bh=lGR5M+pgy/V5MvJvScY51xtKKXTxorKBw/z2FlGce2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K2Ne3MhneklfQS7JRoJ2DWm+9Wm5otZPePWpO+K77OOf5VdIB+hDvRRDs4vcnxZLrIYejJHVu0FdDtgTcCG8kTzEBm/d8SdCIbHYrAHyAR8FPQQm4LrvAwr0+GNmfglscYDKYC8R0BmS4401vF2WIZc+s/hYk5NZT4q1+CFJ54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma3/f1sW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma3/f1sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBEBC4CEDD;
	Thu, 13 Mar 2025 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883206;
	bh=lGR5M+pgy/V5MvJvScY51xtKKXTxorKBw/z2FlGce2U=;
	h=From:To:Cc:Subject:Date:From;
	b=Ma3/f1sWkIypO9P4YVx7uu0n2ZAXSyvsmNa/azkbTfs3p2ALULOwMWYgp3yodhp1h
	 CDl3UrB7aqaMJrMNQcLk6odTGJH8xjhWA/wuILTRO9zeu7P547uanPHgC8wromihxG
	 XXp8EA2s6Vr5rPDwuqqEdZxidyvZfue7jOncY+msYH2hk+SRVzPvUelabULm7fSUlv
	 nueAPT9Ya6G9GF5zEEPOyn5qjQ1RRtRJf70GwoMzfkSFGrzJyLFTZhSDY9UK17QNfm
	 zGDDpDB7zsLphpBBExQqrT3YTWX2oW/PagXsznXCXt4XYGBAVaD8CalHJ3a0u4u1KZ
	 ryNAXjcceTgdw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] tracing: Show last boot module symbols
Date: Fri, 14 Mar 2025 01:26:43 +0900
Message-ID:  <174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
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

I updated the v3 patch[1] of showing last boot module symbols, and
found a compilation error with !CONFIG_MODULES, so this series adds
the fix patch.

[1] https://lore.kernel.org/all/174161444691.1063601.16690699136628689205.stgit@devnote2/


---

Masami Hiramatsu (Google) (2):
      tracing: Fix a compilation error without CONFIG_MODULES
      tracing: Show last module text symbols in the stacktrace


 kernel/trace/trace.c        |  133 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    3 +
 kernel/trace/trace_output.c |    4 +
 3 files changed, 132 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
