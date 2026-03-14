Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2E30BF68;
	Sat, 14 Mar 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483044; cv=none; b=KbBTRiaSvHlCHeIvIO4tA+nE8LHI5BTT3MSEjD8zdWZxmARBFkPTzgx8tzTXv3zus8BRlhEH094bU+qQWUFXRFjOZsExYobWP0BqRC6L1kqFA/TQS5Pp5kABlkRR2Jq00954VxH7FTUCgWV5fohxgF5i3JV1nz40HgpYcIBkpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483044; c=relaxed/simple;
	bh=/fTWZI2BlqxKyMl39TpBAlApdWxk3UMlKo5Mli1rgcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3IQMkKbKGLqDnJJW0xDZRhEHpKOo0C2zajVv5UwRR4VUmaFpaiLTexNXxOuCU7/vrMjkoYgr3v4w/Dq4VBJpXfINYXkQqmE0JP3J8IUKlcciH+wtNTVA2m2PzPDqD741UmXZlN2gVIFKMrNGiCG52PG5rrQgQQHrLzJBFTeLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bObQNXth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bObQNXth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA2C116C6;
	Sat, 14 Mar 2026 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483044;
	bh=/fTWZI2BlqxKyMl39TpBAlApdWxk3UMlKo5Mli1rgcY=;
	h=From:To:Cc:Subject:Date:From;
	b=bObQNXth/5JXjWxZPhliNz1s3Fu8SUxIwwnIaN8cIWK6x1wt0g4NRi6YBdhe6UO04
	 XEAlVuq3fxxiC1kK18absO4twTiRuQlwE8bcRYMsU12bJHnHV1x3Qp/QrplJcL1FqI
	 sZCmBJtPAg+WDMRo5PEfsuMOH/+VhU3XpI/1cJgEI6XhKcsZKWXbwGUuyASSs1EJ7x
	 wyME679BrqJ4zkV+S48uUqyh+jOdymJcH/U1cHsgFe7ZtijX6Km/RgkHfL2iGF4ckl
	 BVA7+wSEjSEQA7mZ8o/zEmPrloVwM55aavv6wuGWFCfl59rQHd+58hKPYLa9lxnwmf
	 +5y7w/od8N2jQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] bootconfig: Add EBNF definition and more tests 
Date: Sat, 14 Mar 2026 19:10:40 +0900
Message-ID: <177348304012.463670.8543295382997674229.stgit@devnote2>
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

Here is the 2nd version of the series to add the EBNF definition and
more parser test cases of bootconfig to formally define the bootconfig
syntax. In this version, I made EBNF part as an independent section
so that someone can refer it easiler.

Previous version is here;

https://lore.kernel.org/all/177347919093.458550.1919253264724868769.stgit@devnote2/

Thanks,

---

Masami Hiramatsu (Google) (2):
      Documentation: bootconfig: Add EBNF definiton of bootconfig
      bootconfig: Add more test samples


 Documentation/admin-guide/bootconfig.rst           |   17 +++++++++++++++++
 .../samples/bad-array-comment-delimiter.bconf      |    2 ++
 tools/bootconfig/samples/bad-dot-middle.bconf      |    1 +
 .../bootconfig/samples/bad-invalid-operator.bconf  |    1 +
 tools/bootconfig/samples/bad-key-dot-end.bconf     |    1 +
 tools/bootconfig/samples/bad-unclosed-quote.bconf  |    1 +
 .../samples/bad-unexpected-close-brace.bconf       |    4 ++++
 .../samples/exp-good-dot-with-block.bconf          |    1 +
 .../bootconfig/samples/exp-good-empty-block.bconf  |    1 +
 .../samples/exp-good-empty-value-sep.bconf         |    3 +++
 .../samples/exp-good-quoted-newline.bconf          |    2 ++
 tools/bootconfig/samples/good-dot-with-block.bconf |    3 +++
 tools/bootconfig/samples/good-empty-block.bconf    |    1 +
 .../bootconfig/samples/good-empty-value-sep.bconf  |    3 +++
 tools/bootconfig/samples/good-quoted-newline.bconf |    2 ++
 15 files changed, 43 insertions(+)
 create mode 100644 tools/bootconfig/samples/bad-array-comment-delimiter.bconf
 create mode 100644 tools/bootconfig/samples/bad-dot-middle.bconf
 create mode 100644 tools/bootconfig/samples/bad-invalid-operator.bconf
 create mode 100644 tools/bootconfig/samples/bad-key-dot-end.bconf
 create mode 100644 tools/bootconfig/samples/bad-unclosed-quote.bconf
 create mode 100644 tools/bootconfig/samples/bad-unexpected-close-brace.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-dot-with-block.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-empty-block.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-empty-value-sep.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-quoted-newline.bconf
 create mode 100644 tools/bootconfig/samples/good-dot-with-block.bconf
 create mode 100644 tools/bootconfig/samples/good-empty-block.bconf
 create mode 100644 tools/bootconfig/samples/good-empty-value-sep.bconf
 create mode 100644 tools/bootconfig/samples/good-quoted-newline.bconf

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
