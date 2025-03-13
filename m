Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DB1E493;
	Thu, 13 Mar 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853828; cv=none; b=PqVCdZltp4ZMamFwjYC0qA2NaKQYhdPH+YbYwKrPt7o1n5XOEDrVIstnFAmjw43hJmGU7rew4w722So8nP/5KoI3otpaUPQGj8UKuEJN4VYTxA4NvTCS6qZ2xj9+onyqmthYAd63dCGOX9ILOn1sri595LHtoFVMl5CGI6tFTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853828; c=relaxed/simple;
	bh=PowFwk1VesE2vSf2ucpAyMxoaxZ3XJqYbaAa32PfkE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfWjzhzrnkb32nMYOnU2Qb6h/P+SIf22mFSOLiZbLw79P48ipz/GLvvfMSIFP0n/jTGBz7X8j2QYJ9RzmBZ7SCG22EDQRNrXwHrHBTUN1lCNBzD1Tg7N7wczUpldHEZ/TM/80nMITTZWIl7/QkshIjCs4PowSnGw9zpfKqiGouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbCyv1ww; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIQpypar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbCyv1ww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIQpypar"
Date: Thu, 13 Mar 2025 09:16:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741853824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgPHorhrqdy4PJe6evDKEIfWw00ftmipyMN5hlayu1o=;
	b=CbCyv1wwdX5sAT8YThZEIy8zab3O5bhh6AsbaTK6LeeKPWQLMPwU8rGPNcT+0G358bY0xG
	EUu66mChbtucDdDM8rBVFsf4xrEfMHYdDQHTPrvIQpdrWnxsAF3cUtrsTqlcgGGbDV2cvQ
	pVIZX4/BZHlgkALOWGU7004gN3hg+zE68A5oOX2J6FjNG+ZV6MfAeA1jHu94KtYq3X02tS
	+dS7bOOTuspdxFDfUo0eDADC4Vh4QAGTTO4B5eWSfCR4+SomVbc27kxZAA9hOuI2xY7iZO
	/5TNbp62iUFRKBmW/RTetlcijXiHHVRaFBI/L+tctPuVrPU6sHVNp1IqH8HFbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741853824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgPHorhrqdy4PJe6evDKEIfWw00ftmipyMN5hlayu1o=;
	b=BIQpyparYK0AOToN+iTWpEBoHigQzhoRCUn9XZ1+4FxC7D7SXNmgsaifwg/I+tn3o+E4lv
	Lwvs+C/st81kCCDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
Message-ID: <20250313081659.N-X57_b_@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
 <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
 <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>

Hi Gabriele,

On Wed, Mar 12, 2025 at 08:58:56AM +0100, Gabriele Monaco wrote:
> On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > index 510c88bfabd4..c55d45544a16 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -16,58 +16,11 @@
> >  #include <linux/bug.h>
> >  #include <linux/sched.h>
> >  
> > -#ifdef CONFIG_RV_REACTORS
> > -
> > -#define DECLARE_RV_REACTING_HELPERS(name,
> > type)							\
> > -static char
> > REACT_MSG_##name[1024];								\
> > -
> > 												\
> > -static inline char *format_react_msg_##name(type curr_state, type
> > event)			\
> > -
> > {												\
> > -	snprintf(REACT_MSG_##name,
> > 1024,							\
> > -		 "rv: monitor %s does not allow event %s on state
> > %s\n",			\
> > -		
> > #name,										\
> > -		
> > model_get_event_name_##name(event),						\
> > -		
> > model_get_state_name_##name(curr_state));					\
> > -	return
> > REACT_MSG_##name;								\
> > -
> > }												\
> > -
> > 												\
> > -static void cond_react_##name(char
> > *msg)							\
> > -
> > {												\
> > -	if
> > (rv_##name.react)									\
> > -
> > 		rv_##name.react(msg);								\
> > -
> > }												\
> > -
> > 												\
> > -static bool
> > rv_reacting_on_##name(void)								\
> > -
> > {												\
> > -	return
> > rv_reacting_on();								\
> > -}
> > -
> > -#else /* CONFIG_RV_REACTOR */
> > -
> > -#define DECLARE_RV_REACTING_HELPERS(name,
> > type)							\
> > -static inline char *format_react_msg_##name(type curr_state, type
> > event)			\
> > -
> > {												\
> > -	return
> > NULL;										\
> > -
> > }												\
> > -
> > 												\
> > -static void cond_react_##name(char
> > *msg)							\
> > -
> > {												\
> > -
> > 	return;											\
> > -
> > }												\
> > -
> > 												\
> > -static bool
> > rv_reacting_on_##name(void)								\
> > -
> > {												\
> > -	return
> > 0;										\
> > -}
> > -#endif
> > -
> 
> I don't think you need to remove those helper functions, why not just
> having format_react_msg_ prepare the arguments for react?

I'm not sure what you mean. Making format_react_msg_* a macro that is
preprocessed into arguments? Then make cond_react_*() a variadic function,
so that we can "pass" format_react_msg_* to it?

Going that way would also need a vreact() variant, as cond_react_*() cannot
pass on the variadic arguments to react().

Instead, is it cleaner to do the below?

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 510c88bfabd4..e185ebf894a4 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,22 +19,14 @@
 #ifdef CONFIG_RV_REACTORS
 
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static char REACT_MSG_##name[1024];								\
-												\
-static inline char *format_react_msg_##name(type curr_state, type event)			\
-{												\
-	snprintf(REACT_MSG_##name, 1024,							\
-		 "rv: monitor %s does not allow event %s on state %s\n",			\
-		 #name,										\
-		 model_get_event_name_##name(event),						\
-		 model_get_state_name_##name(curr_state));					\
-	return REACT_MSG_##name;								\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
-	if (rv_##name.react)									\
-		rv_##name.react(msg);								\
+	if (!rv_##name.react)									\
+		return;										\
+	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",			\
+			#name,									\
+			model_get_event_name_##name(event),					\
+			model_get_state_name_##name(curr_state));				\
 }												\
 												\
 static bool rv_reacting_on_##name(void)								\
@@ -45,12 +37,7 @@ static bool rv_reacting_on_##name(void)								\
 #else /* CONFIG_RV_REACTOR */
 
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static inline char *format_react_msg_##name(type curr_state, type event)			\
-{												\
-	return NULL;										\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
 	return;											\
 }												\
@@ -171,7 +158,7 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 	}											\
 												\
 	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+		cond_react_##name(curr_state, event);						\
 												\
 	trace_error_##name(model_get_state_name_##name(curr_state),				\
 			   model_get_event_name_##name(event));					\
@@ -203,7 +190,7 @@ static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct
 	}											\
 												\
 	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+		cond_react_##name(curr_state, event);						\
 												\
 	trace_error_##name(tsk->pid,								\
 			   model_get_state_name_##name(curr_state),				\

Best regards,
Nam
