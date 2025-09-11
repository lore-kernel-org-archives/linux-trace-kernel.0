Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30623D7CA;
	Thu, 11 Sep 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564739; cv=none; b=WVPbcT2DXDGJKIxLKsfPpUq9a5Z/wz87XaU56YGR6ZNNUNvHn2KbKIdZOI0kXrwsXeSCyV8LwQ9vJaa++x1d3eTAi2T7djj6y4pLBQTQJtTZS6E9zQ+DbcfyLkn9MXh6/DzZd8lhfz4IDsWZ7ceYHfbqfeZzLbyIlMTX15oMAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564739; c=relaxed/simple;
	bh=oJxjCTe0A6srau75hm9/M017tulY0fPNDrsHPUSN/GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV72gSGxR26YsqMmYzbV5gyFoBLYHE0rY1BLcRWSr/is7fldyLOs8bqDw+LHw5KR4gQvdNB9EIF4vEE+GFJTBpFEzFIJqme9rDWfjU+uT1PUMINcmHAkCiUavbYlfF1+OS0pj2I9OXe0izguv0WTVetisCqE6lf2khxLHiF7Jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7C/tN+P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7C/tN+P"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25669596921so2299035ad.1;
        Wed, 10 Sep 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564736; x=1758169536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNBgN/+CL1bSLkrHrjO96e+g8m0fA/zw+kBtZE+AwY0=;
        b=H7C/tN+PlrzoLVkFNfE3emkh9kzZz1X0/DZjPFxuBj7EmcRl2SvrznJQmOdd/qjj0F
         0knuR5pMrSlpUo3cVGUBUYcokw04CVQfHq8Blw5Clr/YvEUj2qGM87sM4t2knyklSmmm
         GCxtHmijQ4rYofgwfls6wc0jTPmTS73uNkgLIQ5t0zBem8AuPNlcxa983MQFf0ulQ7Db
         rKHsyOkPyLigNUCmWnAoTIvkoxb6/YSmG0kVOxyb7uLn75Xh+vpW9OpWEYAphtMYkVPY
         ByPlCUt3aWeuXW7h8LScyd6Pzsm5dUftKKXPaJbkolVCyTpmYLugdk+f0uJuQcqR7n3g
         pfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564736; x=1758169536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNBgN/+CL1bSLkrHrjO96e+g8m0fA/zw+kBtZE+AwY0=;
        b=LlIESm8OtXyT+cJIKMerYLn9KTs2+eUOa3lgq06OGZZ5MgD3vZ1Jbv6mvGIiCao04A
         OzK7300NFs6zMi/TLjybEpGg8AW4iWTKWHpQF1DBDoTfKRUCWx4+kyjpH5YKFeX0jE57
         1/29QTV73X9SFU7FRnlwnAlJV2tqVZYm2hn3XIjQ5+AaPaZAq7mG60UFuGHOIKt63tb0
         tOmK7vK41+GDGDYmLvz0re0rgZ7PfX8o7SupKxpz0Jd0B2CHE/19k3cVs7UttcUHMjnC
         vqtAC6NWoWT1WFUxCUDZI8YPV3FvjOPK9r/Ph2BznBuG1f2F57oeOmpCKhSkRVTZHW3q
         GBew==
X-Forwarded-Encrypted: i=1; AJvYcCWo1GP5gUe2dvt5abXvR+EIOEKxv/llSCYHBXmxhZxSHC6Q4dfy9/Q22kcOeUc4ZnPndPS/4/SmjRs=@vger.kernel.org, AJvYcCX0NrLtPgKt7nmBxu2znNnlf8Ps2VGGSKhf3whJ+Rspz66Hd0Zr/pbmQdxKZLY3VCdDAB5VaxbnGadYxMQ5Gy854fa3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhh2T/MZ/j7SlhWJZq7jcwEgKchmY9kBJYaRrp16bgoh3qe3cQ
	f7oMcfkWGw5HFJCOWbwdGojWugPZc3wvlfiHwPxMQ0N2V79DbPNOHy0A
X-Gm-Gg: ASbGncv9a+KUlPpWd2priGA1aQMOSK+YF+q8PXkQ8ETybHUebAiDYSGj5lterMJBcd1
	lHnoM4hRzgP7N/+VPbcdTwV2pBIHOgnzfJoBZlPRXHrCXfX1xM0otGVsQCozi9hy9D24Z30ZnHh
	q+XxeXyUgE8UTLKljEWEMUuWE/wcHZjLzknTX+itNfJwACQLG3FugkzrwaGDxcC59OzweUS2tOM
	k1f03zoG8VOyRMUmLt+ZoMa8qBPk5BN8wfIV69jsmNNRDSYJi24dfDWqpfH7paMH1Vm09+N5DQH
	5fa9ursOxVrjdsppRpVkNZ1AE07cq5ytbTy9shHzlBbdAC4dvSnl5Z6DRw/jvCY+Dk/DbRNrCes
	ny/svCr0GKsPJqqZ4AXHjU/XH/Q==
X-Google-Smtp-Source: AGHT+IErsMpGM/2IRF+Df83fmIhsASNQKF11RaCOwSfHXLSpjWjHiR+/38PiGa3AWyD/6fBbhbBF6Q==
X-Received: by 2002:a17:903:18b:b0:252:fa17:bc87 with SMTP id d9443c01a7336-252fa17bfacmr196543975ad.53.1757564736319;
        Wed, 10 Sep 2025 21:25:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm4449365ad.40.2025.09.10.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 744D041FA3A0; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/5] Documentation: trace: histogram: Fix histogram trigger subsection number order
Date: Thu, 11 Sep 2025 11:25:23 +0700
Message-ID: <20250911042527.22573-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911042527.22573-1-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=bagasdotme@gmail.com; h=from:subject; bh=oJxjCTe0A6srau75hm9/M017tulY0fPNDrsHPUSN/GE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/M4Hn//pMn2bT2u5WbP1zyN2P7Imz5EX/ngoclXci mNer00YO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRE8KMDCf2TgyKvL0/uVq8 yLj8yF6W7TUPPqc4cc67v1LnnGqY1G+Gf1r2L7+4LPMI8PyT3SZTdin/04zOl7bpMZVLHIX3zW5 dzwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section numbering in subsections of "Histogram Trigger Command" sections
is inconsistent in order. In particular, "'hist' trigger examples" is
erroneously numbered as 6.2, which is a leftover from  b8df4a3634e08a
("tracing: Move hist trigger Documentation to histogram.txt").

Fix the order.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index af6d2e15568ebd..d158dadaa42447 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -186,8 +186,8 @@ Documentation written by Tom Zanussi
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
-'special' event fields
-------------------------
+2.1. 'special' event fields
+---------------------------
 
   There are a number of 'special event fields' available for use as
   keys or values in a hist trigger.  These look like and behave as if
@@ -204,16 +204,16 @@ Documentation written by Tom Zanussi
     common_cpu             int  the cpu on which the event occurred.
     ====================== ==== =======================================
 
-Extended error information
---------------------------
+2.2. Extended error information
+-------------------------------
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
   tracing/error_log file.  See Error Conditions in
   :file:`Documentation/trace/ftrace.rst` for details.
 
-6.2 'hist' trigger examples
----------------------------
+2.3. 'hist' trigger examples
+----------------------------
 
   The first set of examples creates aggregations using the kmalloc
   event.  The fields that can be used for the hist trigger are listed
@@ -1608,8 +1608,8 @@ Extended error information
         Entries: 7
         Dropped: 0
 
-2.2 Inter-event hist triggers
------------------------------
+2.4. Inter-event hist triggers
+------------------------------
 
 Inter-event hist triggers are hist triggers that combine values from
 one or more other events and create a histogram using that data.  Data
@@ -1685,8 +1685,8 @@ pseudo-file.
 
 These features are described in more detail in the following sections.
 
-2.2.1 Histogram Variables
--------------------------
+2.5. Histogram Variables
+------------------------
 
 Variables are simply named locations used for saving and retrieving
 values between matching events.  A 'matching' event is defined as an
@@ -1789,8 +1789,8 @@ or assigned to a variable and referenced in a subsequent expression::
 
 Variables can even hold stacktraces, which are useful with synthetic events.
 
-2.2.2 Synthetic Events
-----------------------
+2.6. Synthetic Events
+---------------------
 
 Synthetic events are user-defined events generated from hist trigger
 variables or fields associated with one or more other events.  Their
@@ -1846,7 +1846,7 @@ the command that defined it with a '!'::
 At this point, there isn't yet an actual 'wakeup_latency' event
 instantiated in the event subsystem - for this to happen, a 'hist
 trigger action' needs to be instantiated and bound to actual fields
-and variables defined on other events (see Section 2.2.3 below on
+and variables defined on other events (see Section 2.7. below on
 how that is done using hist trigger 'onmatch' action). Once that is
 done, the 'wakeup_latency' synthetic event instance is created.
 
@@ -2094,8 +2094,8 @@ histogram::
     Entries: 7
     Dropped: 0
 
-2.2.3 Hist trigger 'handlers' and 'actions'
--------------------------------------------
+2.7. Hist trigger 'handlers' and 'actions'
+------------------------------------------
 
 A hist trigger 'action' is a function that's executed (in most cases
 conditionally) whenever a histogram entry is added or updated.
@@ -2526,8 +2526,8 @@ The following commonly-used handler.action pairs are available:
          kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
               <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
 
-3. User space creating a trigger
---------------------------------
+2.8. User space creating a trigger
+----------------------------------
 
 Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
 ring buffer. This can also act like an event, by writing into the trigger
-- 
An old man doll... just what I always wanted! - Clara

