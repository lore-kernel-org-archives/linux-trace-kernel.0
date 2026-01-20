Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDF3BC4DC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909346; cv=none; b=UbKjSMBAFHcX8CIyuOQfzHrDOfNSRmD4V734T1JUKmLK+V/iOWL7CYE5RbWpHESGZpu8zkTAc7OT/ji2LOyGQvlEbf+kemNWhp7+YsNUcFumG/kJ//MsRktnfM8Dv/aY1znR4IDCCdLEaAQ8BOYtshKBL/83u79RxRnufCaXcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909346; c=relaxed/simple;
	bh=NO4O+jadfWxaA7Ty8u0RgiCU/VRigZY1T4FasUBWO4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpTjAJsNf18e4q9IDtqK6iYfRpvQAunFc0Ip9pZDhCQK8MvyW7U+vDDD08T/TtBdVCfR8WA0ZU+z0yPwY2ar0hZCaSPbyVoI+gpnnJhKhtbpDerE1/iil0v1q1TgggOjLO2u+f0xMnim90I+YwSEHdjt+86oUrocjajhv7cPkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKP5/mQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKP5/mQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768909343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x9nIUBJKZt+7JN/sRL0H1JhPwBVe0Bq7WoXWaZM1Sg=;
	b=eKP5/mQiBPNaGJEwGgNVPGT1Rt2C399mdJtE/Rpa6SjtWNnnd8mO7KFcF7YRaTIIIs+TYU
	8yXg8m0d6Jqvmb5tWAkuCyED9QKaoswN4ooQvMMMHODwyQFljlhIicl1PgvjbIj1JDdXtW
	YVBTBt4CFSkgYyrwnMrCu0DUgZUVK7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-6GE_mRojOWONF6iAO1-tYA-1; Tue,
 20 Jan 2026 06:42:20 -0500
X-MC-Unique: 6GE_mRojOWONF6iAO1-tYA-1
X-Mimecast-MFC-AGG-ID: 6GE_mRojOWONF6iAO1-tYA_1768909339
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D42371954237;
	Tue, 20 Jan 2026 11:42:18 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EF901800B7F;
	Tue, 20 Jan 2026 11:42:15 +0000 (UTC)
Date: Tue, 20 Jan 2026 08:42:14 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] rv/rvgen: fix unbound initial_state variable
Message-ID: <aW9o_lSOvSdME6MP@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-17-wander@redhat.com>
 <7d37e29989e08e62a419f2ae8000ed7ec1913713.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d37e29989e08e62a419f2ae8000ed7ec1913713.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jan 20, 2026 at 09:21:01AM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> 
> 
> [...]
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index 8548265955570..083d0f5cfb773 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -10,6 +10,7 @@
> >  
> >  import ntpath
> >  
> > +
> >  class AutomataError(OSError):
> >      """Exception raised for errors in automata parsing and validation.
> >  
> > @@ -17,6 +18,7 @@ class AutomataError(OSError):
> >      or malformed automaton definitions.
> >      """
> >  
> > +

> 
> I believe these newlines were added automatically by some tools, not sure if we
> really want them but they don't belong in this patch (since 1/26 added this
> class).
> 
There are python formatting tools that put 2 lines after a type
definition. Anyway, I can remove it in v2.

> >  class Automata:
> >      """Automata class: Reads a dot file and parses it as an automata.
> >  
> > @@ -31,7 +33,9 @@ class Automata:
> >          self.__dot_path = file_path
> >          self.name = model_name or self.__get_model_name()
> >          self.__dot_lines = self.__open_dot()
> > -        self.states, self.initial_state, self.final_states =
> > self.__get_state_variables()
> > +        self.states, self.initial_state, self.final_states = (
> > +            self.__get_state_variables()
> > +        )
> 
> There is no strict 80 character limit for python code and I personally find this
> less readable. Is this again what the tool suggested?
> 

In general, 100 lines is assumed the to a good limit. Anyway, this is
minor and I can remove the change in v2 if desired.

> >          self.events = self.__get_event_variables()
> >          self.function = self.__create_matrix()
> >          self.events_start, self.events_start_run = self.__store_init_events()
> > @@ -86,6 +90,7 @@ class Automata:
> >          # wait for node declaration
> >          states = []
> >          final_states = []
> > +        initial_state = None
> >  
> >          has_final_states = False
> >          cursor = self.__get_cursor_begin_states()
> > @@ -96,9 +101,9 @@ class Automata:
> >              raw_state = line[-1]
> >  
> >              #  "enabled_fired"}; -> enabled_fired
> > -            state = raw_state.replace('"', '').replace('};', '').replace(',',
> > '_')
> > +            state = raw_state.replace('"', "").replace("};", "").replace(",",
> > "_")
> 
> Ok this change is good.
> 
> >              if state.startswith(self.init_marker):
> > -                initial_state = state[len(self.init_marker):]
> > +                initial_state = state[len(self.init_marker) :]
> 
> You fixed spacing in 12/26. We could either keep move this change there or just
> merge that patch with others touching the same files.
> 

Np, I can move this change to there.

> >              else:
> >                  states.append(state)
> >                  if "doublecircle" in self.__dot_lines[cursor]:
> > @@ -111,6 +116,9 @@ class Automata:
> >  
> >              cursor += 1
> >  
> > +        if initial_state is None:
> > +            raise AutomataError("The automaton doesn't have a initial state")
> > +
> 
> Yeah that's needed.
> 
> >          states = sorted(set(states))
> >  
> >          # Insert the initial state at the beginning of the states
> > @@ -132,7 +140,7 @@ class Automata:
> >              #  ------------ event is here ------------^^^^^
> >              if self.__dot_lines[cursor].split()[1] == "->":
> >                  line = self.__dot_lines[cursor].split()
> > -                event = line[-2].replace('"', '')
> > +                event = line[-2].replace('"', "")
> >  
> >                  # when a transition has more than one labels, they are like
> > this
> >                  # "local_irq_enable\nhw_local_irq_enable_n"
> > @@ -162,7 +170,9 @@ class Automata:
> >              nr_state += 1
> >  
> >          # declare the matrix....
> > -        matrix = [[self.invalid_state_str for x in range(nr_event)] for y in
> > range(nr_state)]
> > +        matrix = [
> > +            [self.invalid_state_str for x in range(nr_event)] for y in
> > range(nr_state)
> > +        ]
> >  
> >          # and we are back! Let's fill the matrix
> >          cursor = self.__get_cursor_begin_events()
> > @@ -170,9 +180,9 @@ class Automata:
> >          while self.__dot_lines[cursor].lstrip()[0] == '"':
> >              if self.__dot_lines[cursor].split()[1] == "->":
> >                  line = self.__dot_lines[cursor].split()
> > -                origin_state = line[0].replace('"', '').replace(',', '_')
> > -                dest_state = line[2].replace('"', '').replace(',', '_')
> > -                possible_events = line[-2].replace('"', '').replace("\\n", "
> > ")
> > +                origin_state = line[0].replace('"', "").replace(",", "_")
> > +                dest_state = line[2].replace('"', "").replace(",", "_")
> > +                possible_events = line[-2].replace('"', "").replace("\\n", "
> > ")
> 
> All in all looks good, thanks.
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> >                  for event in possible_events.split():
> >                      matrix[states_dict[origin_state]][events_dict[event]] =
> > dest_state
> >              cursor += 1

