Received: from mail.thinkmo.de (s3.thinkmo.de [162.55.237.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE5377006;
	Sun,  5 Jul 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.237.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783248944; cv=none; b=L8SzUOa4hvHQ1eRkEiA56A0wUa5tpYZ1CbgYlOxRriC/twMudQ9JW+o8Nq6zWBzY1lv8tN8ypILVKIQAFIYscXVU0HpUOmE74nIl7FD16dqiL8/cTL8Tkc4bCEGDMn7lgtaLST6NBIAZ3uF4U8kvKvnLrokVNiSimTY2LoCOdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783248944; c=relaxed/simple;
	bh=Jtb591d4drdQdlBQreeCFEdDjy5DmBPqSGwAsh9FMfk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CDAzOcnlZeLTCTJgbs6soLYZdgTZvbvongeWkp38GC6JrnjpQPJLYY/ZDF70Y8Nxkq5CArZcJxI8qjZHQR9NcTtVcKVIn8DFuHPAX+E3XkyV6DKOFoyw7kw2QZlUadc9f3Kpvzxu1VEx0C9vPH1GfM2qS8rQxcSpaCYZPZQmXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=fail smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PZ5eKJtK; arc=none smtp.client-ip=162.55.237.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PZ5eKJtK"
Received: from localhost (localhost [127.0.0.1])
	by mail.thinkmo.de (Postfix) with ESMTP id 4gtPPX2pHHzydY;
	Sun,  5 Jul 2026 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
	content-disposition:content-type:content-type:mime-version
	:message-id:subject:subject:from:from:date:date:received
	:received; s=mail202007.waldi.user; t=1783248560; bh=YjYsDZvFkgX
	3Mukgn3ePSVg2PIArW474YYn9fm8ZGsY=; b=PZ5eKJtKZ6oDdU6LqGPkLoQMr2l
	XFNCnAVZQNIJWthQVLgHHblkWAnwHmzc02lzidP59o7CzDQJWc3DPEsX3tswT8af
	D2FhPCawP7z3ivb4prhcdoUtn3J35tAtM+VCiK6qyVjcdSmQMm7TxX+4WKb7/quC
	lFh8LTb/DZel0A60fgtwOPbyuwDR+d0CG4S/t7IsPp4yh1WLTvt+qzntaRaV6wFu
	91BkaMJm9VYNggYL7K8jOeJ7HUn1MtVoszEKDZOlzDwY8hdQ5R5Sqc/Wno39hybR
	puWnJtQUfoNiGgF2Vr8EvZpzcFzav0Yokn4RtYPvuZq0UGsbwRBPn/NZs8w==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iL7rflBlvAkX; Sun,  5 Jul 2026 10:49:20 +0000 (UTC)
Received: from steamhammer.waldi.eu.org (unknown [IPv6:2a02:8071:5af1:6518:ad11:fa76:980a:620e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.thinkmo.de (Postfix) with ESMTPSA id 4gtPPX1BrPzyd5;
	Sun,  5 Jul 2026 10:49:20 +0000 (UTC)
Date: Sun, 5 Jul 2026 12:49:17 +0200
From: Bastian Blank <waldi@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: Also link in ctype.c
Message-ID: <ako2S4mzIqWwYuas@steamhammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <waldi@debian.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

rtla started to only link parts of the tools library.  It now misses the
ctype information used by all the related string operations.  Just add
another single file to make it build again.

Signed-off-by: Bastian Blank <waldi@debian.org>
---
 tools/tracing/rtla/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 60a102538988..387bc6cc18f0 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -45,6 +45,9 @@ else
   LIB_OUTPUT = $(CURDIR)/lib
 endif
 
+LIB_CTYPE = $(LIB_OUTPUT)/ctype.o
+LIB_CTYPE_SRC = $(srctree)/tools/lib/ctype.c
+
 LIB_STRING = $(LIB_OUTPUT)/string.o
 LIB_STRING_SRC = $(srctree)/tools/lib/string.c
 
@@ -117,12 +120,12 @@ tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
 	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action_map.o"
 endif
 
-$(RTLA): $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
+$(RTLA): $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
 
-static: $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
+static: $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R)
 	$(eval LDFLAGS += -static)
-	$(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
+	$(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
 
 rtla.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
@@ -150,6 +153,9 @@ $(LIB_STR_ERROR_R): $(LIB_STR_ERROR_R_SRC) | $(LIB_OUTPUT)
 $(LIB_STRING): $(LIB_STRING_SRC) | $(LIB_OUTPUT)
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
 
+$(LIB_CTYPE): $(LIB_CTYPE_SRC) | $(LIB_OUTPUT)
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
+
 libsubcmd-clean:
 	$(call QUIET_CLEAN, libsubcmd)
 	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
-- 
2.53.0
