Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A602213240;
	Fri, 11 Apr 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744408304; cv=none; b=Kx1tpaZ05SXgYxjddUahtPecuLESYrTSsnYHAa32V7RXoabONKhEzlIryOch5GEfY/rxgC8pWRmttBJkH+P2XXYfySVjuABwdOQNxKmGh2AmQ2i1FnH9buGsJxdC1FuR845lYD0gzuv862QVR20eaaZOTb/aC8/rs8ddIDBEAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744408304; c=relaxed/simple;
	bh=69qOk6eU2eMUFY/3klKTHwS2QzO2QF7G4qVrEzSnRt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwED5SLgtJf+RyNNJO9zpUj24d6rBWiWgGNBiNZMhd6K4zeP8dfVH5lHOi46MtVDiJd4WhPDsm6yb1TOTtnN+yxAm3fNK2aEOwEhaPlt0cTsxoXV5mah4/WmepOA3VHjydLUy8JNIZLdP6CT244SWcpE3K9KS1S8YIe/7NWTwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCrERvy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCrERvy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565C9C4CEE2;
	Fri, 11 Apr 2025 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744408302;
	bh=69qOk6eU2eMUFY/3klKTHwS2QzO2QF7G4qVrEzSnRt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCrERvy744ahOIYqn3b/YObKg46LBft6tF7c/7vF2cgRC8s4XpbE7jqVZNQERJeZE
	 n09Zvdta81OYruk6d/Gm5NonXeHOW5OOw9ewJomb2cgLrME9nV4Ag3VbCJYOcI6PmZ
	 Z5XIyaiyia1O3UiM+4d8+EMmimhw8bbuu7xtDyWPXwxAsbZxL+bTW83Ou8XBVBnJlT
	 YqqBz3l2IpvGr+5tYDnYV3QnbWQv0kZQ3HrVsNEoHRmOwlUu/KI+tCyvBw59V6B4tZ
	 IgwBuXVqaT0HHZhMuwtJpJmIWrfr2orVXe8HWICkacFVALHdBECsSL0nU0Wmys3W8l
	 kp28FVj9fEhhw==
Date: Fri, 11 Apr 2025 23:51:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Interface for enabling context tracking
Message-ID: <Z_mO6_m0bV-Q8NEa@pavilion.home>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
 <a9d1144e-0f75-4594-b85f-d66b1de623a0@paulmck-laptop>
 <20250410153244.6b20e328@gandalf.local.home>
 <4a90f134-82ac-428e-be5b-916cf031157e@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a90f134-82ac-428e-be5b-916cf031157e@cs.wisc.edu>

Le Fri, Apr 11, 2025 at 12:41:37PM -0500, Junxuan Liao a écrit :
> 
> > > Are you interested in working on joining the noble quest of getting the
> > > rest of the nohz_full support in place?  (Full disclosure: This stuff
> > > is non-trivial.)
> > 
> > I believe the request is more of just tracing entry and exit from the
> > kernel, which just needs a simple trace event at the border crossings.
> 
> Yeah I'm more interested in just tracing this for now.
> 
> > It's been on my todo list to add one for page
> > fault exit (as I do care for how long they last.
> 
> I've added a tracepoint similar to page_fault_user for that but I'm not
> sure if it's the best way to do it. Should I send a patch for review?

If you do so, it may be a good idea to remove page_fault_user and
page_fault_kernel and introduce page_fault_user_enter/page_fault_user_exit
and page_fault_kernel_enter/page_fault_kernel_exit.

But the following is also possible (and then trace/events/context_tracking.h
should be renamed into trace/events/entry.h):

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97..83b1764078f7 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -15,6 +15,8 @@
 
 #include <asm/entry-common.h>
 
+#include <trace/events/context_tracking.h>
+
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
@@ -115,6 +117,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
 	trace_hardirqs_off_finish();
+	trace_user_exit(0);
 	instrumentation_end();
 }
 
@@ -357,6 +360,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 static __always_inline void exit_to_user_mode(void)
 {
 	instrumentation_begin();
+	trace_user_enter(0);
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423..e9395936bded 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -428,9 +428,6 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/context_tracking.h>
-
 DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
@@ -486,7 +483,6 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 */
 			if (state == CT_STATE_USER) {
 				instrumentation_begin();
-				trace_user_enter(0);
 				vtime_user_enter(current);
 				instrumentation_end();
 			}
@@ -623,7 +619,6 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
-				trace_user_exit(0);
 				instrumentation_end();
 			}
 





-- 
Frederic Weisbecker
SUSE Labs
