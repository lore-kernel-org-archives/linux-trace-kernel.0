Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A2394475;
	Wed,  4 Feb 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194023; cv=none; b=hqbwD+TxmmpjkPLSOzGpid+BY3GGUIimUQUouPutbXF7gdh15WUKcL2xzuTQsp5bDe5hRvy3J4TFp9w5gQ/koJJMzbyMzFmT5npmMYAqg5ETNO2BBqBjCTwYucMgTIX9ZFsLOO7Zjor6aUYOuTYuovP+eLA17Zkn7YSbIURQ11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194023; c=relaxed/simple;
	bh=g5tU7LNoFZ8/BpjXzJnw1QqYyUGqiFxzBRvQFBtBt2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUx7DxuGK2o3KvS7+b3Qtsu/yYeAgoQAifV3XOu9C6IQAPzlVM2tJ1v4eR20ci8fuWA+aBDC/fTOqMFrGphRaxDM5WUyPSFQodg0wzdSjB9o6guacXmNuVTMIbBE8MYwMDYnNJuXajtXV8bxqR8HWv9xF2Us+JvmB7FVSCHfZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv28jtHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv28jtHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B74CC4CEF7;
	Wed,  4 Feb 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770194023;
	bh=g5tU7LNoFZ8/BpjXzJnw1QqYyUGqiFxzBRvQFBtBt2A=;
	h=From:To:Cc:Subject:Date:From;
	b=mv28jtHV8dKzUVsrIJfKladV3vM3pES6tcy1cpaNcVT1CZmXiplBPv7Zy+xMMqMev
	 CjbRZP0D9Wy/EloTURsp8tDoXJvEvDR1+Kj6DmaQ+9vHwZDvd7srHDcHTya9zDJndR
	 3kdgGwjHuJDSBmURH+4hMkNwUmyEhU5vm6Llgwl/5U3mEWBqyl+lRu7x1AubIS8pEe
	 NyAcFGRzb6Hza66zaZSs0CkBH50Rg3RjjwebFp87leiuqHALNc4aEfgtz/ZA0+6YaT
	 3TvHXxp4VOSVxyF5Tpg2iu2NY5nsdY/meuW/k9sBw1jZMVKkkiXXJwbtdDBm+oxlV/
	 gaE0vag2aqMQw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] bootconfig: Handle an empty value
Date: Wed,  4 Feb 2026 17:33:38 +0900
Message-ID: <177019401833.80694.554894321526842218.stgit@devnote2>
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

This is the 2nd version of the update of the bootconfig parser to
make it handle an empty value which is terminated by a newline or
a comment. The previous version is here:


In this version I decided to make this change as an update instead
of a fix, since this can change the syntax rule which has been
accepted. In the previous change, it does not handle the array
correctly. This version fixes it[1/2].

Also, I added another patch to improve the test[2/2]. Previously
it just check the parse error, but it did not check whether the
good examples are formatted as it is expected. New test compares
the output so that we can ensure it is parsed as expected.

Thank you,

---

Masami Hiramatsu (Google) (2):
      bootconfig: Terminate value search if it hits a newline
      bootconfig: Check the parsed output of the good examples


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
 15 files changed, 45 insertions(+), 2 deletions(-)
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
