Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297192FB98A;
	Thu, 28 Aug 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366506; cv=none; b=nj89SAHmduPLgarOihxGPn9TyzKF/y/uKeewfnqxjACbKISBms8NO0BVR+rL9gLmjAxsPLkQ/qg5XFad1VwUIbg1v69T3DqmG0VGGp24siIwNEPVdhk/c4BHOzB6N5iVlybs2yTPcT2mmc3lqmdKlRSr3/zlRMXIm37rOIWH0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366506; c=relaxed/simple;
	bh=JoL7MR2CzdQS6BPrywO8jB1PEyibulfdpOOvNvnO3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyX4Opi+HZRx4DTKW4YdXIdeuojqpTXjAEkeXwcEe450JmMbuTqAF9g3WlKYqbBIXptrlTwfHTNbQv4wKoDy6DoMcq/e1ZL/NHV4swq/K4iwW/ii9u9413uOYMIZYGRMZmiR7gn0bOOGympi1YxnOo2FsVI6DHwxzy6hVWZIEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbAztueP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbAztueP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770593ba164so579115b3a.3;
        Thu, 28 Aug 2025 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366504; x=1756971304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwaUG2mqmSuw60xQO2PjnUcliyWKWlyIr1nprl+PudA=;
        b=GbAztuePbTcK9XFKDctFVvUGngyFRyBQ8oxYdZk8TgmcjjxqtJ7uAqd4aHoOUtZFga
         0wjSVs7fCpzGuCSVe8KZNhIKzVyjyoW2pHFti1QdFZ5R1yk4/5Vdm8C/JPT8+/s4Uh0p
         bzvbxJlr4R7acFLFOiOTBM65IZqf2RndedWNueDC5BHCzczUtdzidnduAVTLvKlwJUqh
         FcnjUK6VHlN+A92Nh5jYNspQlmLcAe71IF+8ABHj5gP5caRlOCgwePFOHG+M7dx1BjFB
         6AFXipS7AAaOs5s+vo2HSf3tyZ0o6Hm/8eHnj4hI7jzXy3lS5zaZaAaYbv4ju+U8emDd
         +F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366504; x=1756971304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwaUG2mqmSuw60xQO2PjnUcliyWKWlyIr1nprl+PudA=;
        b=R6u2LEYO2lHHpEuG2UioZ00VvLb7k3FEqgNEv0Z1OUBiXjOkz55MT6ToZH+3T0YYaG
         MRScYxdMP/LIvvtr50UIGnEEYzczXp5h6YF4lQ1Lp+K9uJ+lJv5wVJqCaCnYc6h5qLXR
         FJIz1Q0Zn+eg5qNiAfTN7aTXuy13kCMj0zD+D25G/UYOQ0zFLWyzeI15fh2s08Yj9LCZ
         nRha/lxfAcA56lLDipd4+yKeajROI4j2sGsdRTsjeP9TnSxTmEeqaPDMMOZuyY0lEz6X
         nBHo0Q7PpjGtoWwA0Z/e62RuqfTln/GcsE0zMUWAV2GVh7Egizv3jOxKsG0rP5VUhkgh
         OpMg==
X-Forwarded-Encrypted: i=1; AJvYcCUvQrxIkbjYi1++Hglyl6uEvAxY0fmc6LyGTLFwXGWSY3C/8cn3uiez3YObogSYDkc8w1GcZZGtqS8pQaPlYly9NiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9NcH9s5srg+TO7TKTxhrR0vfltJqUHtYIooOlKQJ7yVoJ+ng
	QVmdKwSdUioBDp8ZuTJfWphi7DD/10hGUv2ZavwKd5whFiKuOeB0UICQtRBgUBc7W3w=
X-Gm-Gg: ASbGnctGKI4MLTJrtcbIsBp7KkF68H4j60DRcyl72enynHCLooHH8dpMh0fKVAuews4
	PrnJlberwbUTGuv8DlVZr6fZsxfzEfRNkwsHW458js30kfWSZs7mkORAkl6t225m2p6xo1HbGuW
	LMLhceJCywWXww05IkG0eyLtxo6jZI4oSDzH2hctWhK840kzRKcKDhemkuhRq//pw1LDJzeSfAS
	U6jIZ8siT+28IWOsVmTLRSAVmRDhxeki9+FlrQ1SGLHZe4BC968BlaDSIRaG+X+hwmfEKO/vXJW
	BykXx2od4OemNBFePZMbf6nXKBcDnwz7QMaTRIXHu8n5vl7Ev0no5B8TKElxx8ombUVbMZTGLZb
	5VIkSL0w3zrenqUMYxthO9lYZcdps9HR3gQZ9bwFNqW1oYTmZVg==
X-Google-Smtp-Source: AGHT+IE7yqNI1wNfU3kqRgvdUB03Q+7fqxylivWelN8xwvP2fUBVMLhtkCKDyOOS3PYiCl6wvaTFUg==
X-Received: by 2002:a05:6a20:4325:b0:243:755:58b5 with SMTP id adf61e73a8af0-24340d920b2mr32588008637.54.1756366504311;
        Thu, 28 Aug 2025 00:35:04 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:03 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 16/17] tools/kstackwatch: add interactive test script for KStackWatch
Date: Thu, 28 Aug 2025 15:32:49 +0800
Message-ID: <20250828073311.1116593-17-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce kstackwatch_test.sh, a shell script to facilitate running various
test scenarios interactively or via command-line arguments.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 118 ++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100644
index 000000000000..af0fbdb3a975
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# --- Usage function ---
+usage() {
+	echo "======================================"
+	echo "  KStackWatch Test Script Usage"
+	echo "======================================"
+	echo ""
+	echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+	echo ""
+	echo "To find your offsets, use objdump:"
+	echo "  objdump -S --disassemble=canary_test_write vmlinux"
+	echo ""
+	echo "Then search for your function names to find the instruction addresses."
+	echo "- Instruction offset: address relative to function's start"
+	echo "- Stack var offset: distance from stack base (%rbp) to the variable"
+	echo ""
+	echo "Usage: $0 [test_case_number]"
+	echo ""
+	echo "Available test cases:"
+	echo "  0  - Canary Write Test"
+	echo "  1  - Canary Overflow Test"
+	echo "  2  - Silient Corruption Test"
+	echo "  3  - Recursive Corruption Test"
+	echo ""
+	echo "======================================"
+	echo ""
+}
+
+# --- Interactive menu ---
+show_menu() {
+	echo "Select a test case to run:"
+	echo "  0) Canary Write Test"
+	echo "  1) Canary Overflow Test"
+	echo "  2) Silient Corruption Test"
+	echo "  3) Recursive Corruption Test"
+	echo "  q) Quit"
+	echo ""
+	echo "WARNING: Each test may cause system crash/hang!"
+	echo ""
+	read -p "Enter your choice [0-3/q]: " choice
+	echo ""
+
+	case "$choice" in
+	0) test0 ;;
+	1) test1 ;;
+	2) test2 ;;
+	3) test3 ;;
+	q | Q)
+		echo "Exiting..."
+		exit 0
+		;;
+	*)
+		echo "Invalid choice. Please try again."
+		echo ""
+		show_menu
+		;;
+	esac
+}
+
+# --- Test Case 0: Canary Write ---
+test0() {
+	echo "=== Running Test Case 0: Canary Write ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "canary_test_write+0x12" >/proc/kstackwatch
+	echo "test0" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Test Case 1: Canary Overflow ---
+test1() {
+	echo "=== Running Test Case 1: Canary Overflow ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "canary_test_overflow+0x12" >/proc/kstackwatch
+	echo "test1" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+
+}
+
+# --- Test Case 2: Silient Corruption ---
+test2() {
+	echo "=== Running Test Case 2: Silient Corruption ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "silent_corruption_hapless+0x7f 0:8" >/proc/kstackwatch
+	echo "test2" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Test Case 3: Recursive Corruption ---
+test3() {
+	echo "=== Running Test Case 3: Recursive Corruption ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "recursive_corruption_test+0x1b+3 0:8" >/proc/kstackwatch
+	echo "test3" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Main ---
+if [ -z "$1" ]; then
+	usage
+	echo ""
+	show_menu
+else
+	case "$1" in
+	0) test0 ;;
+	1) test1 ;;
+	2) test2 ;;
+	3) test3 ;;
+	help | --help | -h) usage ;;
+	*)
+		echo "Error: Invalid argument '$1'"
+		echo ""
+		usage
+		exit 1
+		;;
+	esac
+fi
-- 
2.43.0

