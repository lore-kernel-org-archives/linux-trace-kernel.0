Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BF41754;
	Sat, 14 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479194; cv=none; b=lRCBWXh5ENl1OGPSFdyrW3FW2z76r1JT3uMNkzelSkqpq28iPxR3rbHb0gCR3B0AD/zJYuknKgBw+wHea1DXE67IfD9N3bYtCOM/AVyMqJMfmW4MbHIHsbust7KJSp5K9kIR9ipSEO6KSLvrxlm8EsN6qt8yHH0ETdgH/lvOgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479194; c=relaxed/simple;
	bh=7Bp8k1tvVMu4nu0iZ6CCkIiM/pw3jmZ7I606Orl1pAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tM4toa1b68iMMpf3t/VfmifUariLlzPfejpIj8nLyanDmiO0/OVVeDZJP0OOBDQZfL+LWjLLUM+5Fbf4TeNfTodVhhzDY2EfLSXM27MpUk/SqM1yFSXVxF/982sT+u6taU6xcTrAWptF9c0bncCl8qM0GDJ48AHzDfjnlLmUQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYvVucLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYvVucLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F976C116C6;
	Sat, 14 Mar 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479194;
	bh=7Bp8k1tvVMu4nu0iZ6CCkIiM/pw3jmZ7I606Orl1pAM=;
	h=From:To:Cc:Subject:Date:From;
	b=sYvVucLTiFEsoiBy1nECvEusFAPpIPSMV0JdhESly38Z3/t+GmPCOIEYI8ZBn/OCy
	 Fix3FmWeeAC6R56/5dSaqa60881Bkhm8nHFMILHAqBuW8unMt7R4EJEJ292HIkGo5I
	 241jCJTa6QRHWCLKHIsGi1VkF4favtNykVVarRUX+U13qAbs4NhdjXM4A4O8snWSKK
	 l2/OXXuC2fJucqoYa7LwbXrLxokQE/fKeyECQ9e9V3hoAzm6Gejc8Z5YWwoj3a/gwx
	 /n31eYnpzhXbCth8qdfBPvG2TfGJUi25c+9F54OnG29+WdmjhuqlMsUeE1HoMHoUtF
	 K933PGZrRVFQg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] bootconfig: Add EBNF definition and more tests 
Date: Sat, 14 Mar 2026 18:06:31 +0900
Message-ID: <177347919093.458550.1919253264724868769.stgit@devnote2>
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

Here is a pair of patches to add the EBNF definition and more
parser test cases of bootconfig to formally define the bootconfig
syntax.

---

Masami Hiramatsu (Google) (2):
      Documentation: bootconfig: Add EBNF definiton of bootconfig
      bootconfig: Add more test samples


 Documentation/admin-guide/bootconfig.rst           |   15 +++++++++++++++
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
 15 files changed, 41 insertions(+)
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
