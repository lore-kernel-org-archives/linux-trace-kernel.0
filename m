Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6125785F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621843; cv=none; b=cp2m4J03SeMMof166ZV4KdO3CohR029/+Ba2YvDdRdf54D2w3hTtSC+dKm4Cbr0Cw/V35pBmYoKzP7qUTCQxjk2s2FpgIptmL1ZT4KPuX36a7yWyCdmxVTNaIHqr8F6kJkZZ5uyJdr4eWiMPcKSjgHWJMSetabkqHqLJ9F21mVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621843; c=relaxed/simple;
	bh=EXyB3no/ZYQZiw4k2sIVnM4eV2neGR0XKhmW6028cdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCqH14UAcT71lGauynK1pID6d148eRCEncoQn9WSdsGQxf7abqn5JrylqBVm0KB8r3tfIBQUZDXL7/A5wzo9IuM23t6hYq7+y2LQxjht4XbznoRyVFWTnC0R/Ouki/Og3f5Uh7KtK/Ex33XwsRkMz8UTbbrnnmTGeToON+QeEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmr2ExC/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmr2ExC/"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f75b0a058so37314676d6.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621840; x=1760226640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=Gmr2ExC/ahizGo5cxeQXkFW86dwTO8nMHPObyB+wxLcnWNJ5HdwutrgO0Mltfvv/Wp
         3DpJQx02gbKTeEWPIPcqSZQZ8hZQyQU37b8iulUUG40wb1orggxB4lxiAmQGXdHi7VEg
         Bt/ja8gkzGcXVn510StpEomHonNZ7vA0Tyi1qKzXtntCsPDRxNApu/t0wo1+2M74qprP
         ny0gyr5oZsCrQH8lZJQUIfUnJYjMgPXtQf8/GsKY8akZeD885AmLqo514VWemvjZCD5o
         ODaUnyYMNiG7Y6AVn858kvmzM9f0IPom2W2Lwbw9Pvf0qjT7YRVevUkhPqu95vC8q4tu
         g67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621840; x=1760226640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=KC9E4XPV5+wP5qn1z63Txrk/b3e8/ti8rFvN6f8Wf44nHTD2CgY1wAxs4Xxe/VS1SW
         6rpObLmIhugF5Pa4kFlD6F+j3Q+JEMQduxjah2aikkN7fJdVRjSWFV4ZW2zAxCKmVRt4
         HAkRxoLmYMopbiUQm/0yyy72cy5y9pGV5YUDD/8EcfHK3qCoybDYr1wSHb1t7zQoYMJl
         F2HpIGNXeDA+8wVXTyXxxIXe/FYxd7XhaQEcjlNgmnG3Y944Qb/PS98lm4SIzm9bGuQL
         3sM9UTicnYRWSKQm/ljbBHwxFy3QVCQ8oUVm0zpgl/6CckBayqCLF/Vjqv5oJ264iDoH
         3pXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7xN/Yj55nTyU+c0v8ZCbc8ripHsAKZvz48J8S/JTbKx8vQTepch9XyXCA3k4RgivT+MMQR/QhlBbFf9B2tM/h4XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPqvB4fHt5P2uO1mDTlL2UstPOfKtKX7FgNoEopJJ0UM7xyr4
	jz1jB+iG45DjcSSX7IEiYv/43A+bg571NqLGZLFXcMCpYCvM9q/1gAzW
X-Gm-Gg: ASbGncvY41PqVJlrJmV9EORlau4WKZ/czvLVMypbDd1u5Hcp1sqG43YqJw6i/RqBI64
	shPAYn6OBvtv0pQ2zi90yQCxrLtBsglRHO0XQvORpT26qhfoUvAhBSthFSxwKckjY58VojAMZao
	8cF4CEiO5xVj4HRL+lUJyxy4zie9mHIVlwB9smgeZ56Y6SltQCfwGv5B6LwjuNj5IHbfHv0TsG0
	NONGGxtB2YmawrDy8rfmxc+Nc3Rd3j2n6ba6y+UeB8Dru9E9+dkMbeIythMOtTtn5SYXxvl2Qzr
	Gf20u770bJGrTZ7XehNW75ZcNqlbYw2WqS0fsf94nfj2GQJ5Ng32ctgOlxMYyB31FvCc1BQVMwi
	1zsJwLXpW0S/gYwLNzn7irR4p31fIkv49JbsqhsI+8vktXN2FvQ940KfdaI/j5t4qlrl72hfPx3
	D/AEDXsRgF+78kDvs=
X-Google-Smtp-Source: AGHT+IEUWXDZx+IAlNDV8Mu+BE5kMa9E4iKCTAQ71zUHKPBS5QeBaFqes3mcBdLmYCHeSFsI3jGX4w==
X-Received: by 2002:a05:6214:230f:b0:796:bfca:9c68 with SMTP id 6a1803df08f44-879dc77b87bmr86391786d6.3.1759621839475;
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
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
Subject: [PATCH v3 4/5] selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
Date: Sun,  5 Oct 2025 08:46:58 +0900
Message-ID: <20251004235001.133111-5-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 .../test.d/dynevent/add_remove_fprobe.tc      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 2506f464811b..d5761d31217c 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove fprobe events
 # requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+# Note: list-style specs and :entry/:exit may be unavailable on older kernels.
+# These tests auto-skip at runtime if the list form is rejected by tracefs.
 
 echo 0 > events/enable
 echo > dynamic_events
@@ -89,4 +91,123 @@ if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
+# ---- New accept cases for list syntax with :entry/:exit and !-exclusions ----
+if echo "f:test/__list_check $PLACE,$PLACE3" >> dynamic_events 2> /dev/null; then
+	# Clean the probe added by the guard
+	echo "-:test/__list_check" >> dynamic_events
+
+	# List default (entry) with exclusion, explicit group/event
+	echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	grep -q "test/list_entry" dynamic_events
+	test -d events/test/list_entry
+
+	echo 1 > events/test/list_entry/enable
+	# Should attach to PLACE and PLACE3, but not PLACE2
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable and remove; count should be back to baseline
+	echo 0 > events/test/list_entry/enable
+	echo "-:test/list_entry" >> dynamic_events
+	! grep -q "test/list_entry" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with explicit :entry suffix (same behavior as default)
+	echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
+	grep -q "test/list_entry_exp" dynamic_events
+	test -d events/test/list_entry_exp
+
+	echo 1 > events/test/list_entry_exp/enable
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_entry_exp/enable
+	echo "-:test/list_entry_exp" >> dynamic_events
+	! grep -q "test/list_entry_exp" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with :exit suffix across the same set
+	echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_exit" dynamic_events
+	test -d events/test/list_exit
+
+	echo 1 > events/test/list_exit/enable
+	# On return probes, enabled_functions still reflects attached functions.
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_exit/enable
+	echo "-:test/list_exit" >> dynamic_events
+	! grep -q "test/list_exit" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Enabling entry and exit together does not double-count functions
+	echo "f:test/list_both_e $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	echo "f:test/list_both_x $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_both_e" dynamic_events
+	grep -q "test/list_both_x" dynamic_events
+	test -d events/test/list_both_e
+	test -d events/test/list_both_x
+
+	echo 1 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Enabling :exit for the same set should keep the count the same
+	echo 1 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable one; count should remain (the other still holds the attach)
+	echo 0 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable the other; count returns to baseline
+	echo 0 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Remove both definitions
+	echo "-:test/list_both_e" >> dynamic_events
+	echo "-:test/list_both_x" >> dynamic_events
+	! grep -q "test/list_both_e" dynamic_events
+	! grep -q "test/list_both_x" dynamic_events
+else
+	# List-form not supported; skip silently
+	:
+fi
+
 clear_trace
-- 
2.43.0

