Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4E16132F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621815; cv=none; b=SE6qClCWkKgknl5fmvpdnvVd3X8E6pI11tYdJiyXfZ3bFbiUd49t99RnBxmiazCI3EAhhj6fbZcczSC9M53p7BAgF0fVnt5dFBgEQ4rMeVyQT73edyS6Rux0JoNQ8yiXOgEhYY2hZwsjvYhkEbSIRjT/QJ85L6zRV3hzLYLxHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621815; c=relaxed/simple;
	bh=WtMoMSeSoC/p1iM5dJqIjQogzGbr6NxYCI0Aqh4nLC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7g+Gn783273aQxdp+7VckRzQwWsIRmNTgJ/IAEt3XJp6KBWuqu8fFRGHT6SVaDiHRJRelMRTWwnGPEJwXV4q16LuaEq1T++ixy5DdVIFZCLiUkxhf1B9y953wa1g5Bs96VObd8VduDAVZFm8myOoLO/waC5PFAXMOW0Qxo1t7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Njbcudxe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njbcudxe"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-795773ac2a2so31969396d6.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621811; x=1760226611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=269GcBnSB1zX6TbhiOc5c+3UO/jzniuzx6nJANrBz9Q=;
        b=NjbcudxeOa81OotuJg3GZWFzjf0x/Kw5vUjfhuzbdoPzYXmguL0ywLnbDEsA4skWsf
         Icc6uveLUU0dNrJza9D9b+feLVUN06EzWGyQvh9mq4l/sqysudzQHOESFCJyvUxQQyAM
         lIcPPgIfWw/YdlBxfJKJXdWXKKpdndH6/M/RRL4pQg0dVdYYfDMFABtZqIDqB+3fY25O
         43bYwax4blSW5gCzwXxjeGxBc6ZRcDq+tSoSrfaF88/MkdWcliBhMqVpLpHAxRfhFedl
         hy1mnexFsq3mJ05WZaNcLqyD5CGZIP+mahBCSkjsOoJ/9smmyAZjYoorq0/LHaI+50fR
         HpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621811; x=1760226611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=269GcBnSB1zX6TbhiOc5c+3UO/jzniuzx6nJANrBz9Q=;
        b=ndxtU1z6bfwj5vhYgzupRTsFD4AdGhnlJsYW3Bpt6GwUNX1UNWGL6NoVobzUNCwUcK
         LfAneCy4t/886v28Q+Clnrz8QdvQayXxp1thsqgdYuzvknlKFUTYijkYCf4NDaI2EQGy
         5r4zX3se+PaSfLeOYR2LY8Gjoqat4kFQrKqsDR972VBUVxhii6pgPvkSiHwYLDeTlgWF
         /loc/ULjgwL6Sxm3Z14fqgAGceaQvVBuTq6/rPknJt6ZDgiCaRg3HFE8iyku4jAkeqyh
         sG/H/Z8h/5tah2q0gRqDc4HrkYvsGFRL/urdqPUUwFzkMigI8/WAZ+ljqg8Ij6D0NDOI
         9XyA==
X-Forwarded-Encrypted: i=1; AJvYcCX4t9RnY1lT0nTkxmbV54rCj/0kD92V3LqIobdzzxk2zRh+mmU0A76LbT7BUJNwBYdFdC61jkMg5IVm6q1JD/uHgwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIw1cHUM703iBGoPs0WlUPP6IbSYfG1CZslvdGMHRMezDiNdGg
	LcMDUT3fmIZKVhO6GisucknqQS/nXE2snZzHg3onPSHkL0e/owspi9il
X-Gm-Gg: ASbGncu5d4V0eaMEZW7iNbnczzqzux7q1S6DHsSiUx7ttjBUh2K+1tYP9CiR6mOaJ6X
	x67fp+TmM4QyMMJFdnJ8kA11Yfw4C/mBe9PS2/Ac+F/P54YwlY9516CttYcIxFIVmlkwgUIERlw
	DDSJ+qFLDIaBp2Z6Kdq+DxlqG6/kfmfgSO3xBB8xIkU65JAbDbdGql8/HPlgEtKFaDTcoNfavGA
	oKCLITUtYRhrAwiSEZAH7UR4tEtAKpc1d7vOb283nI+38QyMt6WKvW9hrTHcmtPqNUaZ3K0LwEL
	ooQD5WGoUHOYAIFfxKmQ0NDb4uvPIIxKMunSCgrKi0IctvE8irPf93ayxckvERvx6PV3c5Hub0F
	839VbCLb7VjwXF5UrcvVwgbMVQO/VzJwUPs8vxRuC3nUjKXes+9c2TP9VxUZ9N9FS3/c93NJfiI
	CmskCrGPGwr/IoOZQUQ3e7j4MGLw==
X-Google-Smtp-Source: AGHT+IFqA7ZihIIUPOeSck5FmUA+oqsyZIZgooAId33OvSZXAT8OnHtHAdLcjnfGO2sYAio1j2XwAQ==
X-Received: by 2002:a05:6214:4009:b0:7c6:bbaf:11b4 with SMTP id 6a1803df08f44-879dc882898mr106998946d6.54.1759621811013;
        Sat, 04 Oct 2025 16:50:11 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:10 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 0/5] tracing: fprobe: list-style filters,
Date: Sun,  5 Oct 2025 08:46:54 +0900
Message-ID: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to extend fprobe with list-style filters and a clear
entry/exist qualifier. Users can now specify a comma-separated symbol
list with ! exclusions, and use a spec-level suffix to select probe
type:

- funcA*, !funcAB, funcC -> entry probes
- funcA*, !funcAB, funcC:entry -> explicit entry
- funcA*, !funcAB, funcC:exit -> return/exit across the whole list

For compatibility, %return remains supported for single, literal
symbols. When a list or wildcard is used, an explicit [GROUP/EVENT is
required and autogeneration is disabled. Autogen names are kept for
single-symbol specs, with wildcard sanitization. For list/wildcard forms
we set ctx->funcname = NULL so BTF lookups are not attempted.

The series moves parsing to the parse path, documents the new syntax,
and adds selftests that accept valid list cases and reject empty tokens,
stray commas, and %return mixed with lists or wildcards. Selftests also
verify enable/disable flow and that entry+exit on the same set do not
double-count attached functions.

Help wanted: This is my first time contributing ftrace selftests. I
would appreciate comments and recommendations on test structure and
coverage.

Basic coverage is included, but this likely needs broader testing across
architectures. Feedback and additional test ideas are welcome.

Changes since v2:
- Introduce spec-level: :entry/:exit; reject %return with
  lists/wildcards
- Require explict [GROUP/]EVENT for list/wildcard; keep autogen only for
  single literal.
- Sanitize autogen names for single-symbol wildcards
- Set ctx->funcname = NULL for list/wildcard to bypass BTF
- Move list parsing out of __register_trace_fprobe() and into the parse
  path
- Update docs and tracefs README and add dynevent selftests for
  accept/reject and enable/disable flow

Link: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/

Ryan Chung (5):
  docs: tracing: fprobe: document list filters and :entry/:exit
  tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
  tracing: fprobe: support comma-separated symbols and :entry/:exit
  selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
  selftests/ftrace: dynevent: add reject cases

 Documentation/trace/fprobetrace.rst           |  27 +-
 kernel/trace/trace.c                          |   3 +-
 kernel/trace/trace_fprobe.c                   | 247 ++++++++++++++----
 .../test.d/dynevent/add_remove_fprobe.tc      | 121 +++++++++
 .../test.d/dynevent/fprobe_syntax_errors.tc   |  13 +
 5 files changed, 349 insertions(+), 62 deletions(-)

-- 
2.43.0

