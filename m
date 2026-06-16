Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3135201E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621894; cv=none; b=OxUfxaaxS3dyiKmrry026Ao/hJCz2le7fFhiV+AsvskvNroQK9vu8Fbg2o0x+7MVZQi5Y8ipQhk4kNpm+//P9qbd28qidf45EYcLYT1X2VR8ewR71NlEv/HdyjYC8TSkb1/CQpGDdefRDCWrBtCJWHHUoIwdGwuGhUwTgSSxP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621894; c=relaxed/simple;
	bh=GBbcQ+Dtt+zE/oTQ3XdqrKLWF5yDHnAfA8BhdK5uzNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV+QEzg3JZuZ5zBWjlAUHdbLmAbbDelwq4CtoMpahZ+MNXZ3KUuTlO+7wK4r39C2IAVLKCJjzWTW4lDZCu1Cw64rgWz+ktaqikhJx2WyR25RFtab5T6umYV+ERBeY3saMfx3iSADtWtbO12DV/NwfYWbwUU6Aueo3gJZXwti5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Klap4WyM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Klap4WyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781621892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wY21a+SJ61/cTr41m/qL4v3KzKPZfdNGeLnZZdtyStU=;
	b=Klap4WyMyC4fLneH5DzXHJMvMJjcIVGeG0vlVoYz1A0z/A16FDTVGKx0yccB0PXDpktQqP
	I7on1JJ80kWvma42VhXY75nDbBtT4yeze6NHJcYf0C3xnqA70AlZHH78NeRtOqFRAWZsls
	oK+TP37WZv8vifxtrcFPMbxTLtaT3Ik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-LF7OdOu6NMC57rIDLToo_g-1; Tue, 16 Jun 2026 10:58:10 -0400
X-MC-Unique: LF7OdOu6NMC57rIDLToo_g-1
X-Mimecast-MFC-AGG-ID: LF7OdOu6NMC57rIDLToo_g_1781621890
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-461e0dad8easo237394f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 07:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621890; x=1782226690;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY21a+SJ61/cTr41m/qL4v3KzKPZfdNGeLnZZdtyStU=;
        b=oDOc1wH3ZIPkW458srfQhOWr42NLVq+ZX9F3tuZsWmMC1kdjqX4m+v/rf+FGgk0UqY
         WXLpkbUhy3L8FWb5HydMe40+Qz2OHbiOJgSaYuScIHOsSmR6aUtNqePObZTvxbj/rFaR
         67ZMTwH3/ZpDrF5vUm895EkxEoYpVjCr/5WciQ2KoXCDRDmWzAEb6Mt9tTnxB/kTIl9H
         KJGBBnbrMS6zONf/49NIcR9lmk6UTps6wX1AjVtLXTRrVpmgj3JMV1kRZvM0Hk+S/I8a
         j/KkhpgKbkuV1zS+pegSBbaaXPsR4gDdAzIs1koDzPZGkcZI0okQOsMrDSBUtletFcfT
         w7Bg==
X-Forwarded-Encrypted: i=1; AFNElJ889waT9cT6nfCqTxPhsAR6vWZZoLf/lwizO0B/jKdAreSPJUmf3PrzSh1r0ouyNh1upsy/ucUhjNMepILMkVSHkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+1FeC57+6CfnvZPeMPNaTrVw6Pka4fdv3xrNRYsfIGLLwpRX
	gWOyecTsH0+Ijmq5mqnIWjes1IlbYwtEAJjjU9QC1+rdIzq0oHbB9BPgC9gd+KgWDAl4kYLHEFj
	ix/yj9B82C8/jfkgsut8g/LsVSVfYTNMokTy/RuwGuZvuVusHcZkX6ZPzDI36mgThlcIPcjW7tw
	==
X-Gm-Gg: Acq92OFZUMDA0/3j6VWJCIEajeNGhZ1INLNscZIwMFXrtOwypqc43L+rwvM4qIiJOmT
	eqNJkVL4P5252Mz+wqHciWCA7Q1W6PsD1AXRfAtDNYKGs7gn9Y036Zu81YAIAR7ENlpeYYEo2U+
	zw+A3vkuudbt7NYbGNPVSbPtkmtSSGp74rnpMTrdD4IbEYZfWDzS6cVHmnOBz2RWtm/9EgocPU7
	V44eOvUMgnhzQugzQzs0QOisvzBWo+KcmapIFI2O75SWYao360J1/2rP+OvRWYQc+7I05IEOHOL
	G2KLuyQlttRAAKpV4jN5MZxAONnQqEgnOE3syyrp3XqbOZi45TSkU6me9t7ZYEr6KKSKAbX7JXr
	aTSvtvW0tDBNfLZnZKgTBYUqFbA==
X-Received: by 2002:a05:6000:490e:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-4606da10952mr26129796f8f.0.1781621888958;
        Tue, 16 Jun 2026 07:58:08 -0700 (PDT)
X-Received: by 2002:a05:6000:490e:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-4606da10952mr26129573f8f.0.1781621887250;
        Tue, 16 Jun 2026 07:58:07 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm40350946f8f.25.2026.06.16.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:58:06 -0700 (PDT)
Message-ID: <dee3a6da35a41c9b0344ae610cc277e8488ae20c.camel@redhat.com>
Subject: Re: [PATCH v3 9/9] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 16 Jun 2026 16:58:05 +0200
In-Reply-To: <4aeb668c8446a9f6366d92e218df386bef7bc965.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <4aeb668c8446a9f6366d92e218df386bef7bc965.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mKH550zbeTTY35fLcULPvJdWNCeJ7PfF9CmPH8moaSQ_1781621890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add selftest coverage for the tlob uprobe monitoring interface under
> tools/testing/selftests/verification/.
>=20
> test.d/tlob/ contains both the helper sources (tlob_target, tlob_sym)
> and the seven test scripts so the test suite is self-contained.
> tlob_target provides busy-spin, sleep, and preempt workloads;
> tlob_sym
> resolves ELF symbol offsets for uprobe registration.
>=20
> Seven test scripts exercise uprobe binding management, budget
> violation
> detection, and per-state time accounting (running_ns, waiting_ns,
> sleeping_ns).
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 19 +-
> =C2=A0.../verification/test.d/tlob/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> =C2=A0.../verification/test.d/tlob/test.d/functions |=C2=A0=C2=A0 1 +

Tests seems to work fine, thanks. I think I'm getting what you're
trying to do and probably defining a dummy functions for tlob isn't the
right thing to do.

ftracetest --rv doesn't quite work with different folders as you'd pick
the ftrace functions. We shouldn't be adding a dummy functions script
every time but rather fix ftracetest directly.

Try the attached patch, it seems to work on my side. Then you'd be able
to use ftracetest --rv as you please (folder is mandatory, I don't
think we need a version inside selftests/verification,
verificationtest-ktap is only meant for the makefile just like
ftracetest-ktap).

Thanks,
Gabriele

---
From 32242f83af8214a51c47167a1904d3663aa43870 Mon Sep 17 00:00:00 2001
From: Gabriele Monaco <gmonaco@redhat.com>
Date: Tue, 16 Jun 2026 16:26:53 +0200
Subject: [PATCH] selftests/tracing: support flexible helper functions

Target directory or file arguments passed to ftracetest had
to contain their own nested test.d/functions files to properly override
the top-level directory (TOP_DIR). This works for standard ftrace tests
that would fall back to ftrace's functions, but doesn't for rv tests.

Introduce find_functions() to recursively check parent and grandparent
directories of the target test directory/file to dynamically locate the
appropriate root functions config.
This allows to define additional directories for rv selftests and run
them with the appropriate rv functions:

  ftracetest --rv tools/testing/selftests/verification/test.d/<topic>

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/ftrace/ftracetest | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/self=
tests/ftrace/ftracetest
index 0a56bf209f..5d1b1f9380 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -80,6 +80,23 @@ find_testcases() { #directory
   echo `find $1 -name \*.tc | sort`
 }
=20
+find_functions() { # [directory] [test_cases]
+  local BASE_DIR=3D"$1"
+  if [ -f "$1" ]; then
+    BASE_DIR=3D"`absdir $1`"
+  elif [ ! -d "$1" ]; then
+    return
+  fi
+
+  if [ -f "$BASE_DIR"/test.d/functions ]; then
+    echo "$BASE_DIR"
+  elif [ -f "$BASE_DIR"/../test.d/functions ]; then
+    abspath "$BASE_DIR"/..
+  elif [ -f "$BASE_DIR"/../../test.d/functions ]; then
+    abspath "$BASE_DIR"/../..
+  fi
+}
+
 parse_opts() { # opts
   local OPT_TEST_CASES=3D
   local OPT_TEST_DIR=3D
@@ -159,7 +176,8 @@ parse_opts() { # opts
   if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=3D$OPT_TEST_CASES
   fi
-  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
+  OPT_TEST_DIR=3D"`find_functions $OPT_TEST_DIR $OPT_TEST_CASES`"
+  if [ -n "$OPT_TEST_DIR" ]; then
     TOP_DIR=3D$OPT_TEST_DIR
     TEST_DIR=3D$TOP_DIR/test.d
   fi
--=20
2.54.0

