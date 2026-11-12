Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473746;
	b=w3z6ckOu+gmpxf2W5x54LsSLf/9cMgBbIqiQHltCzKa34/rV0h3XHrF/uQgOwLzw5Ep6
	 NtDwFgHv+2+GdqQJCusV+0EOBsOugOC8+0lHA2Uopiy8opgr1W80R05kzfd4q0xQeCl8A
	 jlItitg4hjUgY+59uh1YAe2o9iYxHG/3KIlJpUu7OB6+Sw8GH3/rIEnkpoR8mvl9BiLhl
	 a1uzMXkn5EPjuVr0iD2CIEItZJCIOqp01C0y2d0WwU/YUhy0+0LtPWQ7JiQ5NMnwdYNFM
	 g4bjLRLtQuC/L63iiyklgFMAuk3K7hI4mb4x/4blc1f9u2Mt3PgBPOg2eu+Fpj7vkhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473746;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=TCu25d7YQ3auCIraQqdTamY0CRB+Uw4hfswgArnbkAw=;
	b=MK+Twgh59teD21HJ33Qa1XvsliWsDVti28Ee3D5fLJzWSlyrUfvqs67JQ5OHCcFePDe/
	 G7kOcj7PnrePDfFWG3h0kQ/ilWZr3PyIHcTD81+nyQ1ZVklKIMzIvfZTTyoSpcRCI2K9p
	 il+anwtxYC2Dbz8rY40aME4DG8OIt5lNejX0BTq29DF8cuq3lGCKYyZRR71emU+GszIbp
	 3/DZkF3YBq1d+LH7Oy3rKkJ1EK19qQ2XDZSs7T4FU2OyddggOvs8JMFURH/gWGSUemz4r
	 UTT5im/o+M6mscYdPatMDrrClCoImHW/6/JmiEptRcnXZovEHsZVPfm4XyENvrkX34w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=JfGNihDJ;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900660A2634;
	Thu, 12 Nov 2026 08:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1900660A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=JfGNihDJ
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jQDkP1PCwzMlYB;
	Thu, 12 Nov 2026 09:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794473741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TCu25d7YQ3auCIraQqdTamY0CRB+Uw4hfswgArnbkAw=;
	b=JfGNihDJUbIo6IwNSjFKk54fFoAD24w0db+eMuqJQtqtmn+f9yX1hx38J1TUxi8yIdfQjt
	PkDcp08QKWcfd7cC6pvqP27TWCF5o34jYqeWAt7iUw59UEYf1VTNCrS4jaNe7DpLiMvzxz
	YGYcUXn/LbG4ZS17hNnmUafTr9T3N8lrB9dlJMKPUVblKvsncUmjCqZPNnwICBbUfD4J4N
	yPunYtH6YOaVnt7fGZI5DK7aP9cO8yX6t2BAdok5hXFvPLOzfHC3OXpCyzr1Ob+bLPfpHX
	vmVh+kEe3K3NY56dcWvEIdf7ILFzYoCHvogO1TpbURuPHomRHNYpi4/3M/hQyA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs, kprobes: Fix bracket
Date: Thu, 12 Nov 2026 09:55:11 +0100
Message-ID: <20261112085511.690900-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8812441d6ea7d1b9a2a
X-MBO-RS-META: zqn69xhbtjwnhytddi4rf9edzixtpgre

Remove needless ')'

Fixes: a1dac767622c ("kprobes.txt: standardize document format")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/trace/kprobes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index 19c04a91a6..91b76ed435 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -31,7 +31,7 @@ can trap at almost any kernel code address [1]_, specifying a handler
 routine to be invoked when the breakpoint is hit.
 
 .. [1] some parts of the kernel code can not be trapped, see
-       :ref:`kprobes_blacklist`)
+       :ref:`kprobes_blacklist`
 
 There are currently two types of probes: kprobes, and kretprobes
 (also called return probes).  A kprobe can be inserted on virtually
-- 
2.56.0

