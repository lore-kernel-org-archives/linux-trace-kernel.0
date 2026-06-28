Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D404346A1D;
	Sun, 28 Jun 2026 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782690718; cv=none; b=GywDfBaexyuDSmqorKFIbUaq0SvuHcJNyXzy4vSuUIAffIXJTlgRvUomKyiPbSMp+rqwlQCai1dJKBBwoh/u7eSLDI0y1amncLWFGYipxL1diDIkjJBYRGeAWsvECeRdqoywkd9bTaFkHPvbDT2t0/s+RA/GeAjZfu4p2HzHZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782690718; c=relaxed/simple;
	bh=iwvJEEmSo6kakYtR3FrwdqO9JhTL7AXMa5BsjUanyOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVpnRk/IMGd7H7gejMHs8KKY4ry9GSiD9j7jlFYpfgZBDVxfrMyf7hdpcI2HpdB18UjTezly5DDIxm7kcqFNilS2PkxWb1kU/w4Z4+OtbusiEA0I4UWiRQLs8n+LC/64fHo1yDWx6IM+VvQt9JaH8VO5I6/RgmaoMhEtu9QYMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hACAtW5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hACAtW5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318C1F000E9;
	Sun, 28 Jun 2026 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782690717;
	bh=DRQQpc50/HOc5q+xOiqMoSHrmuL8PZ/YatZQSWy4Uu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hACAtW5R613z4Zjua5JHlasoogVFRH3raTO8oN8fPcULWJbdtKtG09y3yvVQhjmPh
	 l2sbaPrPPkAaGuAEUql/07B4JkfR2qEwrB0RM0h6bHZKuvq374aCKr03fblRAz/QYf
	 Ssok35UYpQ5SCDutT3p46cwLVG/tnYEOMwZN1B5hWQAQMarghfBVAm4+a+BkFwdogT
	 8Nizkh/0ol1/wYnLfTSdrtvMSaeKcBgtuhs22TaHWVQxACLKe0mk5cF0iXdHQBOn+K
	 2T9Ebw6jeZnOqvv1p1L23PCfLQd3n6FqC1H7R2+PFvwW25fitGIWVz5iO61aVsmOYs
	 OUNBofit4lu9w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v12 03/11] tools/bootconfig: Ignore comment lines in dynamic_events/kprobe_events file
Date: Mon, 29 Jun 2026 08:51:53 +0900
Message-ID: <178269071303.1161310.17843439952709066151.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178269068329.1161310.17763177188897860801.stgit@devnote2>
References: <178269068329.1161310.17763177188897860801.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since dynamic_events/kprobe_events files show the fetcharg debug
information as comment lines, its reader needs to ignore it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 1603801cf126..8eed445c295e 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -57,6 +57,8 @@ EOF
 kprobe_event_options() {
 	cat $TRACEFS/kprobe_events | while read p args; do
 		case $p in
+		\#*)
+		continue;;
 		r*)
 		cat 1>&2 << EOF
 # WARN: A return probe found but it is not supported by bootconfig. Skip it.

