Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D086347;
	Wed, 30 Jul 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886696; cv=none; b=BARHSFjf7TFblaEsIDR/pWCK6o9oRaHWlv5TTZSp66NrxgOsPp5xs97o/+4dQmAS+XOS4viyirSLoHay5M+Nn7kDjlxCMh5aP7cfXn3E8Ib/kXNDwuqBp9l+GDdBVkmZIHwBls38N+2CFS6RXhLzg3o2d1jEySesXRzLz+og8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886696; c=relaxed/simple;
	bh=s4qUs5w7TYKCzP3fgrSvPmZRv/7Htj3Ze6qlqRTJ8kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th/hzBoKtBu9fgYyRM91LJgC8jB4RATwm34k3mumaMyhBwBxtydQ5t6+w7szK/LVnnRVrh7JfTOSZoH35wdwY3Q7nCWpcX4wnMSEN3Y685B1FLA/NMw33Y19Sp+p88hRjJsqMsZzp1AX8SfIUGno1clQdbDQ21gx+1TnqMhGlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Arl20LGJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrmencAJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Arl20LGJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrmencAJ"
Date: Wed, 30 Jul 2025 16:44:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753886692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b74GzSHTdJKYV0DPywTWGn16BcXFlDS22nof6DK0TFg=;
	b=Arl20LGJ4YU3kJ5THWzpj5zvaRyZryx74Pz6rwKC8RosLZDVJRn1mK/Td41rkgIKwbPEgP
	zODlMHJ3vfsmnpiXQ+9hj8kBEwKcjT4HbOAHhQVt41k4RsDOf7HHXutBdbpoxQfxhhlS+a
	+VafWGzwsy8Z4BSh3mUVHTgs2C/6zEaAOA3vpohkSTrqP7JzOcRgMeE/5p46PQdkawGC9q
	Rw82pmmxK2IGOY/LD6ku6sY9J9mk8Lvpg8qirX/tC3h1ek0YsTlvSC7MeWwKs991xJl8cd
	sLi4VlRz/dvi5Lk8gaifxBDmcjBF/+OTkELMZH19Y7ltf/RIQOK2UjiYC4hN2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753886692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b74GzSHTdJKYV0DPywTWGn16BcXFlDS22nof6DK0TFg=;
	b=IrmencAJ715m65uyTTeVP6egJ4lL4mSBwc3+3kS7q7bK5ycuEz0nNpPpBULRHb69OFd1xM
	iK0wDylH9KdAhjCg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250730144450.rpfei2in@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
 <20250729092510._Hq3RWF_@linutronix.de>
 <20250729093717.3AqIu_f0@linutronix.de>
 <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
 <20250730125224.ScWqm03r@linutronix.de>
 <20250730141643.RD-uucXa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730141643.RD-uucXa@linutronix.de>

On Wed, Jul 30, 2025 at 04:16:46PM +0200, Nam Cao wrote:
> Quite interesting that the last "normal" line for cpu1 is:
> 
>             test-762     [001] dn...   112.407548: da_event_sts: cant_sched x irq_enable -> can_sched (final)
> 
> But in the next error line, it mentions the "enable_to_exit". Where did
> this state come from??
> 
>            <...>-1621    [001] d....   119.919846: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit

Never mind about this one, only cpu3 is accurate here, because I cut off
the trace_printk() as soon as the first error appears:

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 17fa4f6e5ea6..927cf2cda03f 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -18,15 +18,22 @@
 
 #ifdef CONFIG_RV_REACTORS
 
+static bool nam_stop = true;
+
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
 static void cond_react_##name(type curr_state, type event)					\
 {												\
 	if (!rv_reacting_on() || !rv_##name.react)						\
 		return;										\
+	nam_stop = true;\
 	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",			\
 			#name,									\
 			model_get_event_name_##name(event),					\
 			model_get_state_name_##name(curr_state));				\
+	trace_printk("rv: monitor %s does not allow event %s on state %s\n",			\
+			#name,									\
+			model_get_event_name_##name(event),					\
+			model_get_state_name_##name(curr_state));				\
 }
 
 #else /* CONFIG_RV_REACTOR */
@@ -136,6 +143,14 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 					   model_get_event_name_##name(event),			\
 					   model_get_state_name_##name(next_state),		\
 					   model_is_final_state_##name(next_state));		\
+			if (nam_stop)\
+				return true;\
+			trace_printk("%s x %s -> %s%s\n", \
+					model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event),			\
+					   model_get_state_name_##name(next_state),		\
+					   model_is_final_state_##name(next_state)?		\
+						" (final)" : "");		\
 			return true;								\
 		}										\
 	}											\
