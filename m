Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322744;
	b=a00kgk/1rGcUJO1cpfhx9vVPgnO0oUWZkR5u2mTVuMEb7W+PzAumz0MKtYOmBLOGfZ1v
	 V2xSFmbZtf4oTfkDjXO6+U8ELXrEk7ZSlhnQBUcdt6f0wKMFFsCRP91hBPfWMbR6pGHX+
	 Qt1zESgawjfIdTaCQrrblcHAezj1Pr/li8bz0OaUyzSThkSD9FXrOrHDcZfVZbagSK8lZ
	 Vg6G8/RyYkagObkooHMyo+a3mCgAhvoP0YiRBNWtWxA+3M15G+eJ080lFWdQm0YWVDs4J
	 maGKmiQlrZX877mUPXv3BWG4wJBag796QhXznQpKwnj3OMH3zZ/uIrTnhvNJw2Hn+FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322744;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Sx9cgUbkh4RV32DkF3afUIrb56A2Z++6wre5+9dXJ3s=;
	b=LbVyewo4ExUWcPLo/Iq+yuBhLowsMMt++PaAUNXp/A7no4UN7rkgsFkim/9nDNsomjEf
	 i9mN8kE9JzkYvZ3KN5bEyb+ovy0L4NKD8H3MG9RaFXAI3GjEIq7Fr4YGqNnDHTT8iHxF+
	 Eo6Nz2MzZnmxY1Bna4FBJu+5orpuaKKtxnLRf3pDbmPUfAYhCAW0Jkc+D3bAL9EQLMqSu
	 8AsRjo7vXDKBD0HTh6pLQ1gGt+H1ImPgJ8GQPlIhtFcc/YzTRsDt7FG8vVYqQbHa8igBE
	 7J2mDn+oz89yQRU1Bn7uJ3c+vHHqlNK2pOL5Vtb3xMbpalfeHYlT1tWMVFPmOHPNX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jxsPVX1f;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA14606A31C;
	Fri, 30 Oct 2026 01:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jxsPVX1f
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AF38EA05F6;
	Fri, 30 Oct 2026 01:12:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C48B620027;
	Fri, 30 Oct 2026 01:12:19 +0000 (UTC)
Date: Thu, 29 Oct 2026 21:12:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] tracing/selftests: Fix false bashism in
 kprobe_non_uniq_symbol.tc
Message-ID: <20261029211218.3749963a@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C48B620027
X-Stat-Signature: isupbdz5emkx8xr1doh7tstj36ztjmmq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IrwqZlzfa0SJGHmF54C1N9es/CffkMgQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Sx9cgUbkh4RV32DkF3afUIrb56A2Z++6wre5+9dXJ3s=; b=jxsPVX1fUpyyeNg5aDIQaxDZdsiEIzo5NKnVxd0Y+j6c7BhsUV0oLNK5UM0kL8OhylVY8QXKHwoaTpDq/HHnhKnZ5/CgCJImJUfIWKpT5zYA2ZlZJp4hQCkrJAZxi9PGw3sRcFJMundSQv4V3g49eY4CwloCexOd1fFPFTdXUJ8=
X-HE-Tag: 1793322739-507075
X-HE-Meta: U2FsdGVkX1933phtu4h//lzzoJEOBrHMnMZtUVx+jtTCoz3HJn6yEM6zf8l8UtEH6VQ9PwhUt8i1PJetWddn9s4dWtnrBwSzIsMh6cuDWSKlrt5QqmsC8NHxBgjH0EpMKVCwjYHK+IIohWn5pVgKJkJTdfYKlKGvCSHfCym1bU2G/cl4+F94C1XChRdskMoUvXKpj24QLH5RAvqVaw3ECi/M4jgxPL7YWJZvGLSAN36tNw7MFQL4jAKkDzF5EXh+DYBEmNB2vTEezS8Ylulkkn9Vtag1hKSZmdstJ/WxNJpb1ePKBqkgnGEC8hR15GNcEYg8Y7Iy349q3XQD7NIkrmPTAopZlQYs8xEGWN6xr2NeQHv+9ZbQm8IITDfZUWaMF8+Idb7oxsaBAxt/+0WGMg==

From: Steven Rostedt <rostedt@goodmis.org>

The checkbashism is giving a false positive to the kprobe test of:

  ($"foo" should be eval_gettext "foo"):
  if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then

This is because it sees the $" at the end of the grep as a bash symbol.
Instead, escape the '$' with a backslash as it is within quotes and that
'$' is for grep to process an end of line character and not a bash
variable.

Cc: stable@vger.kernel.org
Fixes: d22c3e0088e85 ("selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
index 03eb9e70b438..f8e18ea8c268 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -6,7 +6,7 @@
 SYMBOL='init_once'
 
 # We skip this test on kernel where SYMBOL is unique or does not exist.
-if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}\$" /proc/kallsyms)" -le '1' ]; then
 	exit_unsupported
 fi
 
-- 
2.53.0

