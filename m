Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F7239562
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873758; cv=none; b=ToJorj3/z4a58YbWMe5OEjxG3SlVX3SRFER74+mXWsx9dyAkj1zPSAUTr83G6YPhnn2TXC0u2awyR1fY9tX9CdAV25Qhr6VvXkodpF5vlsB838giaxtJC8x4NVdTnAHJaFcXHikC1lQUJlXC9OV1F590WC1/BEFxDmDdGywPRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873758; c=relaxed/simple;
	bh=uHP8ve0rIWQPxaSa6tPdnvdoupveIXTwMedyhVQ8dXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F3vs2u2IllAa4YYjWcVrFfbuJck9TNf+NbzJ6oEhhYd717gmmZij4eEY1IyFRPn09VZ6TDK6l8eHhdv0W4N5ZggYdOKhfFKnIAePIIxrci0TITcOtLvwSfjfnB7T/AiybJ9edsVZhMpQWv3oY3LIXIK4V8rhQFzmnkt740yiyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P66eAMrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P66eAMrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778873755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVO05bCRbFfwqlo/VthLnrU/EdoA/AzPKuZkE7xwyRQ=;
	b=P66eAMrU7LBh9+gGI58J2hUrSzOX0Oc+70LWjcRoxatz9trGNgAso9+d6ibg0VG/2LD/CZ
	R+XRUrGeNSrMrg6I52cysXK26NyaEH66Tb+nvW+cDe34XtTOsraYqluH+dM1Bo0kL6k5E9
	D+PlK6vR9dgidYZSHksNkzfM7pWdgpM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-jk1R3mVlNsiZJCTKSWnsBQ-1; Fri,
 15 May 2026 15:35:52 -0400
X-MC-Unique: jk1R3mVlNsiZJCTKSWnsBQ-1
X-Mimecast-MFC-AGG-ID: jk1R3mVlNsiZJCTKSWnsBQ_1778873751
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 948DB1956053;
	Fri, 15 May 2026 19:35:51 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.80.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B6E718001D2;
	Fri, 15 May 2026 19:35:49 +0000 (UTC)
Date: Fri, 15 May 2026 16:35:47 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] verification/rvgen: Convert
 __fill_verify_guards_func() to Lark
Message-ID: <agd1Tb8RDUqfjaGn@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: lBcqBf1dCD_ByhYAzM3tNqfstb9gg9l80IW4KNdVzxc_1778873751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2026 at 08:59:27AM +0200, Nam Cao wrote:
> Prepare to remove self.guards and self.__parse_constraints(), convert
> __fill_verify_guards_func() to use the parsed transitions from Lark.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/verification/rvgen/rvgen/dot2k.py | 39 ++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
> index 3a39ae29e41e..cf7e5ddc649c 100644
> --- a/tools/verification/rvgen/rvgen/dot2k.py
> +++ b/tools/verification/rvgen/rvgen/dot2k.py
> @@ -221,6 +221,20 @@ class ha2k(dot2k):
>      def __parse_single_constraint(self, rule: dict, value: str) -> str:
>          return f"ha_get_env(ha_mon, {rule["env"]}{self.enum_suffix}, time_ns) {rule["op"]} {value}"
>  
> +    def __parse_guard_rule(self, rule) -> str:
> +        buff = []
> +        for c, sep in rule.rules:
> +            env = c.env + self.enum_suffix
> +            op = c.op
> +            val = self.__adjust_value(c.val, c.unit)
> +
> +            cond = f"ha_get_env(ha_mon, {env}, time_ns) {op} {val}"
> +            if sep:
> +                cond += f" {sep}"
> +            buff.append(cond)
> +        buff[-1] += ';'
> +        return buff
> +
>      def __get_constraint_env(self, constr: str) -> str:
>          """Extract the second argument from an ha_ function"""
>          env = constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
> @@ -398,8 +412,9 @@ f"""static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
>  
>      def __fill_verify_guards_func(self) -> list[str]:
>          buff = []
> -        if not self.guards:
> -            return []
> +
> +        if not self.has_guard:
> +            return

The signature of function says this function return a list, instead of
None.

>  
>          buff.append(
>  f"""static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> @@ -410,14 +425,22 @@ f"""static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
>  """)
>  
>          _else = ""
> -        for edge, constr in sorted(self.guards.items()):
> +        for transition in self.transitions:
> +            if not transition.rule and not transition.reset:
> +                continue
> +
>              buff.append(f"\t{_else}if (curr_state == "
> -                        f"{self.states[edge[0]]}{self.enum_suffix} && "
> -                        f"event == {self.events[edge[1]]}{self.enum_suffix})")
> -            if constr.count(";") > 0:
> +                        f"{transition.src}{self.enum_suffix} && "
> +                        f"event == {transition.event}{self.enum_suffix})")
> +            rule = transition.rule
> +            reset = transition.reset
> +            if rule and reset:
>                  buff[-1] += " {"
> -            buff += [f"\t\t{c};" for c in constr.split(";")]
> -            if constr.count(";") > 0:
> +            if rule:
> +                buff.append("\t\t" + self.__format_guard_rules(self.__parse_guard_rule(rule))[0])
> +            if reset:
> +                buff.append(f"\t\tha_reset_env(ha_mon, {reset.env}{self.enum_suffix}, time_ns);")
> +            if rule and reset:
>                  _else = "} else "
>              else:
>                  _else = "else "
> -- 
> 2.47.3
> 

