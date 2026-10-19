Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4AEECB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368274; cv=none; b=ax9mWmgjkHZaVl4MzHCbIgmFtaZslY9HAa8xJSe5nhc/9UeZlBEChRDwBvGEYT27276MpHl4qw1EKk2RL2gYfIldvGm+AkyRsIuwik85Y9nW691o8ON+i64YlNn5sWP/n9kM4XVaSeQIdqRJqOSYMSKs1dH37s5PkxBpNGIaVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368274; c=relaxed/simple;
	bh=PytpAivb1fwxvfwewsqyJs+b7ShzSeJ8NAvBdrPtn/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pK2KDFwAyfsVp0IYn66PdeeXtHTE2pm9SdEzH+PNl4VzHStt1d1pp/w9f7N9wqNX+6pMwe8Ow7of0TjaMIYJu5MdKlO/ZgD0E5EhiJiptxrorbl9uaTut5ocsmajFNRoeGUdxsJ8cQYjzQX7j2KEElV0sB8p2+TtGqkMkHodkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zirc/ri9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zirc/ri9"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7fccba9c675so3714481a34.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792368272; x=1792973072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAzJZZYXVc0Jc7U3TE8nNL1ig5ACrPJZxsjIWB1n0Xw=;
        b=Zirc/ri9Zrfn5dPtL9q903JSIUp+Zq5JaEL9hTXxKUbgTc1kjPDyjsQsYOqx7x1AlW
         bFrEZhJDCPeqebZP/0Pgpo6PsNlDWUSou6Y0VPpsPw+zoFWPkgwrZ/kdLarP2R0w07FW
         b1TA2bDJbn6Sw+0/LfyfOs0Fh9FbaXCJrRLicodmFElbKeRICLw9wURitjDPpvjLd+8N
         sWhybucv+HFe67k3dCzdyT3k1pKeeeiIRoZFlcZnk5rBg7aAjosmtPs3ug1s5Z8vA3Rn
         E5bW1zT+S7THtjch3ma5hzSpr1V7Y6etqvUbTiK55hbPGx4CErvYgIGgAGyZQAJeF9Sc
         hq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368272; x=1792973072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAzJZZYXVc0Jc7U3TE8nNL1ig5ACrPJZxsjIWB1n0Xw=;
        b=jPV5nd0eg088tOtoLGGH+jYCkKgh1Bp36vLEU/0bVNyA1mkLlcuyRqf/Y4AsaP+03E
         EC2xbTFb7yIYMCfzIsnSkI9HtNEC8sGdXqj2inxDCAKZ7PTkcmf7+rCAkd27VCb215oI
         ZWBZrcKEWe0uuabWflUU3EQ32R/BaTrnOmyfrAau0G+ELsi8isFJ/Y21nFCcTDhQ+Llj
         4zbTgado/rUeOtq93xBuokhvMy7SPDe8Y03/t8P08+dviKFKDc1WVlhkvNcruWeXHXL+
         +cej/VAYbztyUOCfKOOucN0t5YOueymnG8Hr6hqXn25X5eDnaSrNmICIuQgghJx73Gq5
         lOBg==
X-Forwarded-Encrypted: i=1; AKwUvBw8+PYBSFpq14LysHnmQQWkbjZxWcp7HPq32QCJ0oXTxEYw94i8v8u636n28Q2+MAJwJ8wdBKK8paTqnr/A5yc9drc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/m3I5QXLrDKWCrKdqwGMD0NYZ1EUUtrRMBRDT5baKohhbLMsa
	FKOqTLGG6ThKKDB17dZ+OS12Okxav2QUDwqMmcsVu9hJ/CXIZSwMyYby
X-Gm-Gg: AYBFou3lZjU7Zvgri+wDdkuk034v9spdPHcu7jL6a028WAjMI4VlY8Hp1vbq48mzaMx
	qunUmSeQ32Ix+qBoHoDkkC5SxeK3X4/UbEwT1jLD2CVrUodJ1yCbw2S5/RHjRU/3Q4Kbbhsdd+o
	+tEXvbTL6fqhl5URcXwgAa8ecRZO0HQQaW3A7TYHDvG+qr6u50ZJ7qbBEpnBlk04WJ/2yMbBdmy
	1lK2Xo6zGYXOw/mvOAu3xSQQZMC/JlYoUIeB9U3Jl27znC8y0j/03bIWOC9s3RtsC04dp3Bw/D1
	kEG07V+CRRNNfXtz5b4mUNEGvnmCRxh58o/C0UUhO6cuxnP+kAgbBzvAI0MHQlvbPn/Xe8SYWXt
	8p9XWgwkuUU/kpEOxH0xic9mxKI4c471wuTkqD95YYIlTpeB/7pSA+Vc5W6JotqF79rNCVxROkR
	AGIokaVhMh9EsYpSXBBFJHdGv7GmHs/IEp/99vUefI69f0yYmkyvXJPH6iF4ZatitH+40waP5WB
	H2w6dJALzv+
X-Received: by 2002:a9d:7f8c:0:b0:816:f1c2:d6b8 with SMTP id 46e09a7af769-841ff60e1b5mr4883351a34.9.1792368272518;
        Sun, 18 Oct 2026 17:04:32 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a00f15sm7674561a34.8.2026.10.18.17.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:04:30 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leizhen Zhang <lzsx618@gmail.com>
Subject: [PATCH] tracepoint-update: bound section names by the section name table
Date: Sun, 18 Oct 2026 19:04:19 -0500
Message-Id: <20261019000419.3977860-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_tracepoints() finds its two sections by name:

	secstrings = (const char *)ehdr + shdr_offset(string_sec);
	...
		idx = shdr_name(shdr);
		if (!strcmp(secstrings + idx, "__tracepoint_check")) {

sh_name is a 32-bit offset read from the file and nothing bounds it, so one
section header can point the name anywhere and strcmp() reads from there.

Found by fuzzing the host ELF tools with mutated object files under
ASan/UBSan. Reproducer, setting only sh_name of section 1 in an otherwise
valid .o:

  $ python3 -c 'import struct
  d = bytearray(open("tiny.o","rb").read())
  shoff, = struct.unpack_from("<Q", d, 0x28)
  entsize, = struct.unpack_from("<H", d, 0x3a)
  struct.pack_into("<I", d, shoff + entsize, 0x7ffffff0)
  open("t.o","wb").write(bytes(d))'

  $ ./tracepoint-update t.o
  ERROR: AddressSanitizer: SEGV on unknown address 0x7f8d689ae848
    #0 in strcmp
    #1 in process_tracepoints scripts/tracepoint-update.c

Skip a section whose name offset is outside the name table. Such a section
is neither __tracepoint_check nor __tracepoints_strings, so skipping it
changes nothing for a valid object: the reproducer and an unmodified object
now both print the same "no __tracepoint_check in file" line and exit 1.

This bounds the index into the table, not the table itself: a name table
whose own sh_offset or sh_size is bogus is a separate gap, and in the
elf_map() path used here there is no mapped size to check it against.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Assisted-by: LLM ASan UBSan
Signed-off-by: Leizhen Zhang <lzsx618@gmail.com>
---
 scripts/tracepoint-update.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 5cf43c0aac89..2736e91e6f06 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -157,6 +157,7 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	Elf_Shdr *shdr_start;
 	Elf_Shdr *string_sec;
 	const char *secstrings;
+	uint64_t secstrings_size;
 	unsigned int shnum;
 	unsigned int shstrndx;
 	int shentsize;
@@ -171,6 +172,7 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 		shstrndx = shdr_link(shdr_start);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
 	secstrings = (const char *)ehdr + shdr_offset(string_sec);
+	secstrings_size = shdr_size(string_sec);
 
 	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
@@ -179,7 +181,10 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	for (int i = 0; done && i < shnum; i++) {
 		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 
+		/* sh_name is a file-supplied offset into the name table. */
 		idx = shdr_name(shdr);
+		if ((uint32_t)idx >= secstrings_size)
+			continue;
 
 		/* locate the __tracepoint_check in vmlinux */
 		if (!strcmp(secstrings + idx, "__tracepoint_check")) {
-- 
2.34.1

