Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478957;
	b=fXkO2UhUFYidkESnGGf3VARfRYbkjq9G71VfUM95B3c/g1MRp0iJAsu7g1rBH5gHlMol
	 RBV/gE2/a8fWD/4incAlwmWdQq3HopkUoiDNa3i99PivZE/okZLp5rrM2xNlIMdeQ9w8W
	 bkX+3Xhh/oM3CCRT8sLXOeKYrqL1KORq5ZEZS4VwR9W6rIhzqP5MtRvcVbScB8vUB/jgT
	 qeIaW6LjzNpK4kVukL6KuVcs6E3AExGIFnmElBMtgZN1atFNXmXVowfQy2b5+PpYuRP7u
	 bzbakFkmE0kxGVyEn8Vs7WXFi7ngktgS0b0GZnUZnNAcGyVnxSZ+ht9b4kZo499F35Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=inWYmIxz6VFGDkaCA3AF8RBW2atE9l0zQleo2j5RdtY=;
	b=tw9bViQiAySBQZ9HeN8RoZLE4o3V/+ucXsVqegc/q1AI/gD2liWzIs0ELqdpdCxPXaTz
	 Vwj+RkZTPeHvJBUYdksgjvaYd3X0kavmDDOoOmGLPBqR1iMTbWoN002M6ZbzMlEBxiYX0
	 ILN86U4yMBjI4VQg093nQUDrSLWPkv2cRA+sfjswei0UYwc4X/mi0kbbVjLkGtfm2Pmv7
	 L/YNT5lUUA/asHgqX5ZDKLdXiRonsQUDqT6yLRtl98YrJS+OsVOJ1vpTYKAPfUIZF/+So
	 7tRZrILsMVEl815fUPICYavGagdmpd2HN8wP8+cA9GusIJBH8JpOexyVzl+IAprL0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVROfkn0;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8F606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C8F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVROfkn0
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so5055692eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 02:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478956; x=1795083756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inWYmIxz6VFGDkaCA3AF8RBW2atE9l0zQleo2j5RdtY=;
        b=gVROfkn0IBUBn8WsD9STCPXOnFDT2DiXvQrwKw4x9RJDgovnX4BBNg8CheYTVkU9fa
         DE333abaVUYD0B7qoUBkxFnoRZ5yyny93zrg3JMXb7hnTJWXi7MkL83GS5hHLASiNj3F
         6l3WFsv0/+Ete+2BKpTJ+r6ujOe8BgOszVE3xWnTTYPahcEQbmW7EPgtGpWss4gBAA7e
         YXa0CFSYYtawNAPFXpuRSyG/HG0bxKQoZMLSTNJj0WaibAeO01lhFnsj8veKklxwlO6a
         75NkdD1LBdbgkRNffz8ercoTsCLlR6HfUKAdhfnyLWbGgtl20sW49gnqqyq2B4dmP4bu
         YgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478956; x=1795083756;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=inWYmIxz6VFGDkaCA3AF8RBW2atE9l0zQleo2j5RdtY=;
        b=urjzKVbJ+NsXQ/TKNgEC7ksv/Y9nkYPEuOtwsnrhatAKy52x1AAKqnhnmKYA4GzvZV
         sSEW+r5+YE/v6CcezLbDc6oyeh5olRknVU6yruROLoMawehHRvbQGPoJS8j7zNGtxVDv
         ixgWCakXM4oVxJ8tHLSeW9++Kk2Z3XkZwuS9ENfc3gCiLZqp7nufzsDumVxj5LcCHxut
         yHEzpnDE5uGD4UpBui8N/VbjDgTOGiPasXHnLvqTuYcIMBGDwVLfNppaiHYVRvrVzzT3
         c3cOp/AnLgy7vuUobT4MdPMoUW5M/r9o+ASatC4tAZ9RuuMZawcbcoBx8uSYDF6g0TyR
         owOw==
X-Gm-Message-State: APuU4Z9DeS7bNTPhpQfiSmSK27LKnJe8Y6KxiQ4bysUSumdoC9pmC/ZY
	PSXDFawP7g7bPbXkiDE040o/uR7IrEbvvPhXSM31sdCnR2OcpcnPL8yRXDnXOi4uO5g=
X-Gm-Gg: AYBFou31MQ+iMYxyyaelMSkLbFJMrTpYQgYdTYpZXfORwb8Cw9Czey30hkW/3GMrmC/
	pHA8VDV0YsPIHkmBdJsB4omOFs9SISxdQTh57OcmA8x/bNaRfSUx1JiZ2dsq7x0k7mMDzpCKzSV
	15Ov8216UGTHMWCckBAPDxOPI5VtrYya006XoqeiDnDGl8IDV1mzbjJY3NsXBC8AFKSpagEZxWF
	Q4jrcp8A5JnkUUNn8M2P5B4/OLhxZvsR1HqO2cMcLlCIV8EkX0EjZudkyF+qOs2bYzKrwd+VEkH
	H6CxnkKMLDgsXkNMOsMFMpRg9cHNv/lMIPA2uQtE7JI66cVQfda7kxz78on7okOFIMxZP7ozESf
	mIJzKLdoqa+Ox8d42S1+ylQrk0CcOxRl/UI7g0x3Xl9deM5jal4fjh/TgyRUzndPP4WrhpZwW1M
	eg+MbJyBOewhIhnFqAlnxZZPmAX3WPkkYv6kxWLJU+HuApSJnlChDhGQaTjVFLXUAl3v5rBtSYG
	d5TCUHUyLSdgluLDl0dWB2RXintOtJ0bDnESdxHbzhepIVo5Li0SegJJId4/IKqQQ+ZtSGBCISF
	B4iKb3iXNmNibp3x2gVT28dMYKxrIg5RyUBBKjCO6A==
X-Received: by 2002:a05:7300:cc9c:b0:36c:b8b1:a44f with SMTP id 5a478bee46e88-37686466019mr5517230eec.31.1794478956100;
        Thu, 12 Nov 2026 02:22:36 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm46483638eec.18.2026.11.12.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:22:35 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rvgen/tests: cover an invalid monitor type
Date: Thu, 12 Nov 2026 18:20:20 +0800
Message-ID: <179447882047.254241.3226415982233977960@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From 0c12bf144a7267be93a9e45d872eaaf0c8a2d841 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Thu, 12 Nov 2026 14:26:11 +0800
Subject: [PATCH 2/2] rvgen/tests: cover an invalid monitor type

Add a rejection test next to the other ones, so the new check is
exercised.  Without it the command exits 0 and leaves a generated tree
behind, so the test fails on both the exit code and the message.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Assisted-by: LLM
---
 tools/verification/rvgen/tests/rvgen_monitor.t | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t b/tools/verification/rvgen/tests/rvgen_monitor.t
index 5f2562600..2a48a7b54 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -64,6 +64,10 @@ check "invalid monitor class" \
 	"$RVGEN monitor -c invalid -s tests/specs/test_da.dot -t per_cpu" 1 \
 	"Unknown monitor class" "Traceback (most recent call last)"
 
+check "invalid monitor type" \
+	"$RVGEN monitor -c da -s tests/specs/test_da.dot -t invalid" 2 \
+	"invalid choice: 'invalid'" "Traceback (most recent call last)"
+
 check "missing dot file" \
 	"$RVGEN monitor -c da -s tests/specs/nonexistent.dot -t per_cpu" 1 \
 	"No such file or directory" "Traceback (most recent call last)"
-- 
2.43.0


