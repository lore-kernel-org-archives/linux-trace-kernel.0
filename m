Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37C1C173C;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979730; cv=none; b=l36CL+cl3jUtFb8lowhgleNhm+D7CeD3AX7gX4WdnbXmGmrsCSXTMX4prXrfuvhFS/OOivPswOhZLaj14/n8U5syv4A81z4Z//D4Et5IC89qwlh+PjGPEFBYaLTOkuxIiPIUcJmPtbuK6mgyOSMWvkVPRN7PwEWYwStRLaX0MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979730; c=relaxed/simple;
	bh=tzrmplEy9kKioRPkGlCFGTsuQtb3WcTGH/B6HEXRfpY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qvZdmCq2yD6PldAU4Rt9t23j7Gs3Yqv6mFlQk+szb9TWghfknponR6cjkkVDLIEfZ89fP4fqAMuN+0iDAH+0tyEaQy55S3ES12W1YzGyITwvTcsRTNiWG2KSLW2VHPyATdO2r32dTrTFJJorwg4t3s7OgThcoQ4PSX7Xtu48RjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B67C4CEE1;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPnUr-0000000DcnI-2v6p;
	Mon, 23 Dec 2024 13:49:41 -0500
Message-ID: <20241223184941.544855549@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 13:46:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] ftrace: Remove unneeded goto jumps
References: <20241223184618.176607694@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are some goto jumps to exit a program to just return a value. The
code after the label doesn't free anything nor does it do any unlocks. It
simply returns the variable that was set before the jump.

Remove these unneeded goto jumps.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 63a9ffa65e17..2c1691aa1d2f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1669,14 +1669,12 @@ unsigned long ftrace_location(unsigned long ip)
 	loc = ftrace_location_range(ip, ip);
 	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
-			goto out;
+			return 0;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
 			loc = ftrace_location_range(ip, ip + size - 1);
 	}
-
-out:
 	return loc;
 }
 
@@ -2071,7 +2069,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 			continue;
 
 		if (rec == end)
-			goto err_out;
+			return -EBUSY;
 
 		in_old = !!ftrace_lookup_ip(old_hash, rec->ip);
 		in_new = !!ftrace_lookup_ip(new_hash, rec->ip);
@@ -2084,7 +2082,6 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 			rec->flags |= FTRACE_FL_IPMODIFY;
 	} while_for_each_ftrace_rec();
 
-err_out:
 	return -EBUSY;
 }
 
@@ -5720,12 +5717,10 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 					   parser->idx, enable);
 		trace_parser_clear(parser);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
-	ret = read;
- out:
-	return ret;
+	return read;
 }
 
 ssize_t
-- 
2.45.2


