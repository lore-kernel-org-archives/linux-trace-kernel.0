Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003226B2D8;
	Mon, 19 May 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644146; cv=none; b=HKdKxxV4UqFQgv4UJ1Y2GGSZi9Q5K42+J4tzl/f2GKhpKwoZ5WEEAX+HsxAZt6F/j3Zfm00HSLtC9EgK1KIxxPoUI3VsetFqVMlx4MOtdhquYr2eIFIRceIpEUZA5wmAhtAZm4cwDaDu/zrGFNmV9V66lXE9XPnFB7bKKflSVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644146; c=relaxed/simple;
	bh=/HRLDkt+Ui17Ewjay2IkB2Ip02Jr3M9xwlPXp7quBVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdk/4DmM0slBbgKAApSLzxk2ZlrTRhKvidk2NB1ixwfHc3rrCWicmbUWy/8KNyPJ7+aBod7dkhAe+Pqt6XG1Rj8aPEZzD3BpWfVTcLDcASs3AD4nfZo6+pLEeiw5M2CHRcM/Jaz60qfyKpzxt9S20qGkstn8m2u2FNqd9GVSD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyWqfl2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqomLv1G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyWqfl2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqomLv1G"
Date: Mon, 19 May 2025 10:42:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747644142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCQgi10UR992dlQaoDPJB7yxvwRcrEs7GWQVXJ/StA8=;
	b=vyWqfl2e01zzIkoAlczlLbWUZsXt3dFksf2d0OsI9vjBOZEBCeWAuQ1aTB5Pwebs2dMShy
	FfYUtKMWXG34vxokQ3xeeLsTXmiLT6C+pBh9K7gwuI7dkch6pnlG6E/ft0rlh3pH0g/h2J
	3dE6gd4Wd5VNq28Sw0wShGkfZlfAaRPRfsWH1uSks/GOtojb7uCzqsDExH4le7p5nt/Sfw
	5dwIRqNymrKZQX8mu6GsDQ+LZQVcXTN3p3mjBDOGUXZm3OFY31tkhdMlPwqQqvEr+p4RE+
	ahYQWHklXVxaDveXunbVC3kZMmC/U5hpRrBKkf2UZNQ/jhWEKBPHkiq238Y6Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747644142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCQgi10UR992dlQaoDPJB7yxvwRcrEs7GWQVXJ/StA8=;
	b=aqomLv1Gmgp7tEXc8UIWNdjxYTH53YmENrIPEIM37jiONNWWjvTBMotaA7OwApJrXrwvUZ
	mhuDNhOCakK05fCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 07/12] rv: Adapt the sco monitor to the new
 set_state
Message-ID: <20250519084220.iProU-cg@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-8-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:09AM +0200, Gabriele Monaco wrote:
>  	.function = {
> -		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
> -		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
> +		{     thread_context_sco,          INVALID_STATE, scheduling_context_sco,          INVALID_STATE },
> +		{          INVALID_STATE, scheduling_context_sco,          INVALID_STATE,     thread_context_sco },

This is over the 100 column limit.

I know it is not your fault, this is generated. Back when I was playing
with DA monitor, I made a patch to fix this. Maybe you could include it in
your series?

From b4fb648398a29a9c0d8e08bd12394978d3948a5e Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Fri, 15 Nov 2024 14:56:33 +0100
Subject: [PATCH] tools/rv/dot2c: Fix generated files going over 100 column
 limit

The dot2c.py script generates all states in a single line. This breaks the
100 column limit when the state machines are non-trivial.

Change dot2c.py to generate the states in separate lines.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/dot2c.py | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 6009caf568d9..abc0ee569b34 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -152,29 +152,22 @@ class Dot2c(Automata):
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
 
-    def __get_state_string_length(self):
-        maxlen = self.__get_max_strlen_of_states() + self.enum_suffix.__len__()
-        return "%" + str(maxlen) + "s"
-
     def get_aut_init_function(self):
         nr_states = self.states.__len__()
         nr_events = self.events.__len__()
         buff = []
 
-        strformat = self.__get_state_string_length()
-
         for x in range(nr_states):
-            line = "\t\t{ "
+            buff.append("\t\t{")
             for y in range(nr_events):
                 next_state = self.function[x][y]
                 if next_state != self.invalid_state_str:
                     next_state = self.function[x][y] + self.enum_suffix
 
                 if y != nr_events-1:
-                    line = line + strformat % next_state + ", "
+                    buff.append(''.join(("\t\t\t", next_state, ",")))
                 else:
-                    line = line + strformat % next_state + " },"
-            buff.append(line)
+                    buff.append(''.join(("\t\t\t", next_state, "\n\t\t},")))
 
         return self.__buff_to_string(buff)
 
-- 
2.39.5


Best regards,
Nam
