Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD818B47C;
	Sun, 16 Mar 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127717; cv=none; b=aJNZdi7f1FB2sngK8NmWfp0W6jaMeD6EHlIF0b2rZ8HJsN3mWNzrJtVxyq8tzVBSoiN7km+GxETHM6kPkfPpXHr7wlcCHl9zq4TVYQBCB50jUGTgLTWK9r+t8F0710wiUARwn/XF9ghBUrdo3LkBPImXayQH6QvPFonG+uXLIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127717; c=relaxed/simple;
	bh=y26tfEd3RrwIby+c9q4PmhmcouiauWQ8HV8iy1l4U3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEOfDLUQ4koRgudZSX/BXh+dQjT43OkMAZRkNER4UmxsayWcfAo+UJili18ZBoe5rDzVfflVtYmz4iJLatfoPzhSHJQpWuUUhhQO2w4dq7PnV2RimPXE5uEf8tjihwo4hBckL5+Kc7Rn32Pi5WLycYCA/QucyX3bq6kYyd/U3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZPActpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZPActpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641EC4CEDD;
	Sun, 16 Mar 2025 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127717;
	bh=y26tfEd3RrwIby+c9q4PmhmcouiauWQ8HV8iy1l4U3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZPActplDB7iTUEFZYECTRc5twmgJVus7StJps9Bke4kX5VDlfPir5JuriSqc7gNS
	 GWgAd2wz+oKPrho5rgWsNYIUIRxZZOcrfCVyKPHYGsWX+rNzcFKyjGqHzlLoTwhC/C
	 F2UhWrXfod5voQ5hw90+I8rEm4SuLDvTFisUPYZeLzY/MDthNsFfgprdYqAdNHxGvP
	 LPb5/S5yJx12AcOfRNLMzfTXv8Xnj4MGTqMxamnJALlraBYHSbxW6Rd/qyMXeEtUNI
	 bNSyXKQa9Am3AA7Aw23XzdjKMokC6BaRyB7rVlnF7CazvLT0zDfdx9gMlnbL8NDo7k
	 ijXLPyXbg6C6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests: tracing: Enable fprobe events before checking enable_functions
Date: Sun, 16 Mar 2025 21:21:52 +0900
Message-ID: <174212771234.348872.14455715715729686727.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174212767109.348872.18231451508464729427.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   30 +++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 449f9d8be746..603dad73e7e8 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -12,6 +12,18 @@ PLACE3="schedule_timeout"
 
 echo "f:myevent1 $PLACE" >> dynamic_events
 
+echo "f:myevent2 $PLACE%return" >> dynamic_events
+
+# add another event
+echo "f:myevent3 $PLACE2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q myevent3 dynamic_events
+test -d events/fprobes/myevent1
+test -d events/fprobes/myevent2
+
+echo 1 > events/fprobes/myevent1/enable
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
@@ -19,29 +31,22 @@ if [ $cnt -ne 1 ]; then
 	exit_fail
 fi
 
-echo "f:myevent2 $PLACE%return" >> dynamic_events
-
+echo 1 > events/fprobes/myevent2/enable
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne 1 ]; then
 	exit_fail
 fi
 
-# add another event
-echo "f:myevent3 $PLACE2" >> dynamic_events
-
+echo 1 > events/fprobes/myevent3/enable
+# If the function is different, the attached function should be increased
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne 2 ]; then
 	exit_fail
 fi
 
-grep -q myevent1 dynamic_events
-grep -q myevent2 dynamic_events
-grep -q myevent3 dynamic_events
-test -d events/fprobes/myevent1
-test -d events/fprobes/myevent2
-
+echo 0 > events/fprobes/myevent2/enable
 echo "-:myevent2" >> dynamic_events
 
 grep -q myevent1 dynamic_events
@@ -53,6 +58,7 @@ if [ $cnt -ne 2 ]; then
 	exit_fail
 fi
 
+echo 0 > events/fprobes/enable
 echo > dynamic_events
 
 # Should have none left
@@ -63,12 +69,14 @@ fi
 
 echo "f:myevent4 $PLACE" >> dynamic_events
 
+echo 1 > events/fprobes/myevent4/enable
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne 1 ]; then
 	exit_fail
 fi
 
+echo 0 > events/fprobes/enable
 echo > dynamic_events
 
 # Should have none left

