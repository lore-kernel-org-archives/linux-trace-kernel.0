Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9C45C0B;
	Thu,  5 Feb 2026 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252380; cv=none; b=Fwmd9aSY5umkbkpCCMKzJJQJfB2yJPNg8ZVGsX6ADrhSvWmAIaB8lYiuyysqp5aJoE960MRPUaFH5rJiADBn6iL6AjPSWY3zxuMVCxacv0wOUm0rxbCnY9XU2POkpTWJ0JPv3NtDQTTrqTHfU81zUslzoikZ0iNgDXas3aQnqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252380; c=relaxed/simple;
	bh=i+5G/JlimAZa08xhLvoeMujw3fT/v+FdIjHFJt1CgmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GP1jS4RORiLVjKAtFUJ9pWcVBp9GAuiMpJlD13br/02Bsk2belybCPIR/GPSGWNe3HFlJdwd648uUwwc3NIi8lyt6QreC4XNwUA+qErT1MwnTz4LvWwez5XhjiYnAJ8WuUtJUZmEoQ3w8h2aZf6s/iC1c51rNE5yjUoqkDbMPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1OOGldN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1OOGldN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E826C4CEF7;
	Thu,  5 Feb 2026 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770252379;
	bh=i+5G/JlimAZa08xhLvoeMujw3fT/v+FdIjHFJt1CgmM=;
	h=From:To:Cc:Subject:Date:From;
	b=Q1OOGldNQf/HLBmlNXNsA3BTaJTlRMXam1rI+2vRVaAFZQd6RzcnV0ltioQSIqMww
	 kgpFHg8BrDOMpvPHEyPpIKznodJpSTetayizKUEULSZmjajtACghqeCt/bcUw2jRTL
	 ZGPN7TB8BD44/TwEBHQpfp3aM/c5gInAoNgR6Zp42cZRZ5r+aa+WCgc8gdF5QmN+7B
	 2xRh0ZOpmsK4yTqTzx4dlUuHYKsfXzmRSYyh5wO+ysQrcmEjTasZScSSFOxqVhw/Vq
	 4l6iceJdVX6bzUUAA7oxvfSv+LZYTB5V2MYcZteFyMKJtrH77vfllY5XN3cqtVvpcx
	 KiTDD6dCxC6LQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] bootconfig: Handle an empty value
Date: Thu,  5 Feb 2026 09:46:15 +0900
Message-ID: <177025237564.14982.14899224362754775890.stgit@devnote2>
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

This is the 3rd version of the update of the bootconfig parser to
make it handle an empty value which is terminated by a newline or
a comment. The previous version is here:

https://lore.kernel.org/all/177019401833.80694.554894321526842218.stgit@devnote2/

This version fixes typos and add 2 bad examples which were
previously good[1/2].

Thank you,

---

Masami Hiramatsu (Google) (2):
      bootconfig: Terminate value search if it hits a newline
      bootconfig: Check the parsed output of the good examples


 .../samples/bad-array-after-comment.bconf          |    4 ++++
 .../samples/bad-array-in-next-line.bconf           |    4 ++++
 .../samples/exp-good-array-space-comment.bconf     |    1 +
 .../samples/exp-good-comment-after-value.bconf     |    1 +
 .../bootconfig/samples/exp-good-mixed-append.bconf |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv1.bconf  |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv2.bconf  |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv3.bconf  |    5 +++++
 .../samples/exp-good-mixed-override.bconf          |    2 ++
 tools/bootconfig/samples/exp-good-override.bconf   |    4 ++++
 tools/bootconfig/samples/exp-good-printables.bconf |    2 ++
 tools/bootconfig/samples/exp-good-simple.bconf     |    8 ++++++++
 tools/bootconfig/samples/exp-good-single.bconf     |    3 +++
 .../samples/exp-good-space-after-value.bconf       |    1 +
 tools/bootconfig/samples/exp-good-tree.bconf       |    8 ++++++++
 .../samples/good-array-space-comment.bconf         |    3 +--
 tools/bootconfig/test-bootconfig.sh                |    3 +++
 17 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-array-after-comment.bconf
 create mode 100644 tools/bootconfig/samples/bad-array-in-next-line.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-comment-after-value.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-append.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-override.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-override.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-printables.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-simple.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-single.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-space-after-value.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-tree.bconf

--
Masami Hiramatsu (Google) <mhiramat@google.com>
