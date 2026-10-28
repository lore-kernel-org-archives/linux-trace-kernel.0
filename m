Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202340;
	b=wnfP6Vg0D7phggTW4DwQ5iYr2cEUCJrieng+mPCdit44xRK3gqhx9X1G2sTfx4iYdrpJ
	 GEKDjSO/6nQ9S69HBvsvY+O8beMTUFdfr9BuEA7KsWT9vaoEyWfN8jfV0k1WtFgmuuzUI
	 tvQuIct6L3qao7m/B5GrkbsPjB/l2nii3ODF8f4obUav4iovRJY4KJi/qIYyYrKXRMRPP
	 yFKxawLfdo26AMr/cv3JZusi5rVBYutT9IXmJ/2w6nWQLtKx2j6Mb5RD4cO0XxMUTKBfS
	 EQVNlq7bTnMuvNwJepVuzZeP3HkDpqpAItmQkue5DzklgjCY9iZbg1laF1bnfQgIPqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202340;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=PjvkM0OMA9RN5UF/XKulpRmneokYpYi7ED1YTZAedG0=;
	b=hnEHT267EAJRimo6vZ2fvPSSnrB3cd2GFOHVle8oda7Q6/eN2JSct77dQjBVNIvVDdaF
	 m3WiIKZOz9f16prUOv7eS66LgvocmW72OnYeIBd4RvzMOzXO9IgxnHab5Nf3U1pFoRtI6
	 A9ms9/WL/EbiOmEvCnQ2c49RuTdSCLswsLT5stqMhDF2VUJchOOPtV1d6yYtttSTN+MeF
	 YRVZAzGCGY+1rCd8vVoCT7eTnw2L3DdaBvTWO0O4fqxkT9CXCxN7WJSU7p86JOI59SghL
	 M65Iewmv34YkNKpMnsI1Xvkhm8vRzyFROXqRNnQUGqh5TTAkVId9xMrLU0eqr1rJD6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=anE6x6TP;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6E60A5BE0;
	Wed, 28 Oct 2026 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD6E60A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=anE6x6TP
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id EAAEDA014C;
	Wed, 28 Oct 2026 15:45:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id C8C7020032;
	Wed, 28 Oct 2026 15:45:29 +0000 (UTC)
Date: Wed, 28 Oct 2026 11:45:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <20261028114528.137acd81@gandalf.local.home>
In-Reply-To: <auIRtQjGjb0yeYCX@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
	<auIRtQjGjb0yeYCX@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iauxkrgitzb4y5ns9qiya3qx9fwnuzuy
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C8C7020032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XIK/kfw1PI2Z0ADRFxHDZXbDniCLupa4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PjvkM0OMA9RN5UF/XKulpRmneokYpYi7ED1YTZAedG0=; b=anE6x6TPYTkXdLon7cc792bqk+XSaD9sZv+Rk//qg5pbzwwbUwVd8TaQbq6V34HJPbV8RG16oSQtN31KMsDnCWGlY9q0UnTGhd2JqPLILPk0ojxxWjv2SPtLzafS25y+oAUFL+yjCrfg4piy8WIjCyT/fwbSNN7pkx4C2pI4ZVY=
X-HE-Tag: 1793202329-749645
X-HE-Meta: U2FsdGVkX18sSkuYD8K21lvIRfdzm7jh9OtGlPWjwMM6Aa6wPT9ngrklzDGkn5LBq9YghsVZqsdnh/3stqcZeVtLjP76sSo2UIgMzzzx9kUvT9Bi3p26VR8QSNS4aQNL4hgwHmxvhT6AqPSALVmWYj/0qGnwop1FuDRhDrjy7Cd8PW5cGKbpwqW/Cc6fD74IuZHS3aJ5XztSrmXPmyIMAPLir9G32Hn4BeM3muKMET4N3WJMMaSe5mce6ZjKMdQvGVy9WvJ12ig327ArPjOMNl38dMIl4S4v0m5YroF9aYYit3yJpVAoW+1r30JQWmkNqdMFDiJ+QStGf9sGTYhgLd360kqxaK6dv5TDEvJVargpgBF2KeAPFxorIcWQEOlo0v/spSyvfUUgl40bJV6j2Vx8UpFQ59RN5g+JcSJK8w8=

On Wed, 28 Oct 2026 11:16:05 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> On Wed, Oct 28, 2026 at 11:05:58AM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
> > included into lockdep.h via kernel.h pulling in trace_printk.h which
> > includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
> > does not.
> > 
> > In order to remove trace_printk.h from kernel.h, have lockdep.h include
> > instruction_pointer.h directly.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks Yury.

Peter, can you give me an Acked-by on this patch and then I can add it to
my series to remove trace_printk.h from kernel.h as that depends on this
patch.

Thanks,

-- Steve


> 
> > ---
> >  include/linux/lockdep.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index a6451ecbbe9a..c6b0168f5fc9 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -22,6 +22,7 @@ struct task_struct;
> >  #include <linux/list.h>
> >  #include <linux/debug_locks.h>
> >  #include <linux/stacktrace.h>
> > +#include <linux/instruction_pointer.h> /* In case _THIS_IP_ isn't defined */
> >  
> >  static inline void lockdep_copy_map(struct lockdep_map *to,
> >  				    struct lockdep_map *from)
> > -- 
> > 2.53.0  

