Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E401E991B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102291; cv=none; b=iqhUmMVAknci3qmG6p37a0vLFPWU+DUejWmhzY37J322n+eNUr5gGwK3l66LzFXq9z9i2woGqLAl0IO39rOfOUK5WyPUMgOv2s1PpsT67+6376aoTBIo9kax4FuPrDss4EKT8tisgCTPTqWYpMSjWayy0OBpgbSckNZCT21PgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102291; c=relaxed/simple;
	bh=3xlG6FYPR48UFVUeYAAdpz6olWhBuChTlR4EX2RSTmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aazD0DkihML/yUbOAVPK0hb0j7oji43a+wIHdrQW6NCCt3VA1SxltcH1smI+rWsZC6xsUGSvO/xjG1+pkCNiSKano3S68rW1jS2cGuT2ASlhZREurZ6Pd03l4LnrXdKPo5jkX88vt6QVpPsFVTbVXWCA7M4cbm3PhAudH0Eh+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1/G7Rmc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1/G7Rmc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0b4320665so17852045ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 15:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102289; x=1766707089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZalkBGMZvwmDVV1ya5Lu+/scueeEmPRx1djh9JCuvk=;
        b=A1/G7RmcE7cGjd1dxvzoC95Z8nI51CDGlxCnREHw9mmwY2xu5/CjXHMPUGJRKRk+vB
         0CoiFwlBS/q65WgLOiP6gXisaDm/zp91p761jF8J1l0wBqJOTx2pzdnNxyUdKgD7WVgZ
         VgrErL6lZGv0dc8kiNHeKFfc6t34RCgX1vZpWG4KNK23hoRqTZc6IxHMyEd+/Fn4Eh1J
         BnnSWzPj0+VCGAEA+ZMOIV32J2HZvPJg9lXrQLac5b/FgPX0dD8oSMEdrY6csNL0HqEu
         kqmIvW4qHSQrzkLHTA8PDSQURIyc2WVpsoBSBPxkumBPqFlkMFJ1phDKmB2pnNy2abRB
         CzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102289; x=1766707089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZalkBGMZvwmDVV1ya5Lu+/scueeEmPRx1djh9JCuvk=;
        b=WcCBbAbeHLE5/lE1b901tR0vGuVpCCKFpH6ecT4ObYveLkYEowbQBKEQiI1bY6lC4d
         3E2qVtBeXjW5YNMzl+aafsm5EfCm6MjTIzAu9706ZZLRLH5lDItwiTvFUhMzTaz8j6ON
         vqouWRLGe/ZJZCxVdmtzqFJu0VMtBlgxJXJ/p0t5N/NwO/p4MWCw0Z9ij0LeR/dgVUm6
         RNBRCNx2W3FbWQ+wmbQfbuV7tCvmOluXWuJrg7NWl/QkWY8gBMUVU040HhZKYk5BbTZo
         O+6v/6Y5MOmvSh+sKPBr8J8Bz5/+e7byB1ojXi+Lp8TQZVW0Ukpw9VF2icO8gVg+2uKX
         D0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUy6BcfZlWUKBvU5BjCzgJOBd3Lm0MyLPHJcu9HWIzqdFrL3RbxhBbQ/dnW5j0dacw1aqYhknFqjxiIzEz/Q9i+fpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3PSMwyKyXpuEYh24Sg9yHooW3Fpyxoah9CAodGuXIVLiRMj4
	iQuRqLSltICFYXw4jlWVhx3k2LyGSwNiv2LKRka5o2ZeccZc0HvfUyD27UStSw==
X-Gm-Gg: AY/fxX7b5xB1GEJtZOXKoJK6N0NOP4pwDuiql42zaeq4W7B4IiuYwfBETszPfkuQCiJ
	Vg8EpZ3XQj0KHCUSoV/cGa/3H8IFFsppdJvWUiaKG22gEHA4PFagZ2biS57avgNZCZRnffj4DNl
	+GjNqbwcUP31fs0PjlUGI8lJoF1SgYxu/ga7jybLCxD/4Wu9Zu/2WyxKlK4hg7yJ+5axTjuIml6
	T9tcjwLrLWhYNChhoqTG/Rx6ov0LPLSOhZGqTKMZFmiSyJxors/zLqH/xNjf9hieDUvZp4SWNHx
	cYr8J9hSZhYWPyUJ+xRkgsW+EEv9/N0Wd/I+HO+mf7H3ok1/4x6LL8wH5oi6Fi5oBXyAQ5BAKdh
	nItpRrE49/i70YMyjswiCe6cxVhUqxwhPgN7ljnut0lE6iYq/d2B+EGFkJntSvOytg3NY7KOqNT
	37EdZ4sXfpyUY5clXR
X-Google-Smtp-Source: AGHT+IF21Ecc6Jc0533/8GWL1yiDmEnXNfeJkD3kNuw+xcQOMYUm7A56eghLjVuqVAs0d9Em+kHEaQ==
X-Received: by 2002:a05:690c:7012:b0:78d:6d62:f93f with SMTP id 00721157ae682-78fb3ed3062mr7661257b3.8.1766094799618;
        Thu, 18 Dec 2025 13:53:19 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f01e5sm2294447b3.35.2025.12.18.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:53:19 -0800 (PST)
Date: Thu, 18 Dec 2025 16:53:18 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aUR3zqq4-qMV_bFh@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
 <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
 <20251218124326.22334325@gandalf.local.home>
 <aURlK1gpCrfLEKN9@yury>
 <20251218162542.476009db@gandalf.local.home>
 <20251218164103.3c535de3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218164103.3c535de3@gandalf.local.home>

On Thu, Dec 18, 2025 at 04:41:03PM -0500, Steven Rostedt wrote:
> On Thu, 18 Dec 2025 16:25:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 18 Dec 2025 15:33:47 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > > > I don't actually remember why I had __trace_puts() pass in the size. I
> > > > could change it to:    
> > > 
> > > This is the best approach. I'll schedule it for v4. Would you like me to
> > > take it as-is, or you'd send a patch?
> > >    
> > 
> > Let me send an official patch.
> > 
> 
> You can find it here (I Cc'd you too). Feel free to add it to your patch set.
> 
>   https://lore.kernel.org/all/20251218163739.5605f9ea@gandalf.local.home/

Thanks, will do.
