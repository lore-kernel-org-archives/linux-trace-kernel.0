Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19C433E75;
	Fri,  3 Jul 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107226; cv=none; b=qI7NA2CkBpRhBscFE1qetbUf4kbXay//bNKplDpkQlOZBGvU5DOikH64m7yBzMb1dNW6GEYueE+w/wpAIf3evBPx0WdAxUGs2Pe7+pByWf3c2vWELMOmv2Dgpv55y5qjQBm/gIEm+7CHqkBGUGnzexJWkY/Jr6cniCWp+xNMFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107226; c=relaxed/simple;
	bh=hhfznA5dyyqV912eE8X+ph5nyOQ/Xj42XKgUKPNL4Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdIchXEt0nukC1r8IdioH4DTeqxIdTIqH8w6ARJbzl1ymKowHRea+F+35TA4i8GDqQQEcrQ1IcDY/3XwD1LGVXkBSyPgmV35Njv08hXn9HB5+KegJsJbLlsKjhyJzsKdzTx6VW7Vb0p1qTv6jqqHzcbOaMedXf4qiSODgEYr7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 73D541402AC;
	Fri,  3 Jul 2026 19:33:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 8688820010;
	Fri,  3 Jul 2026 19:33:35 +0000 (UTC)
Date: Fri, 3 Jul 2026 15:33:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tracing: Cleanup event_enable_trigger_parse() by using __free()
Message-ID: <20260703153341.0b2117fe@gandalf.local.home>
In-Reply-To: <bc9627b8-90fe-42f4-82f1-541bd96866aa@web.de>
References: <20260701174829.67ab8a33@gandalf.local.home>
	<79106214-b341-46ab-8810-a206ce8fad29@web.de>
	<20260702165346.035f8eef@gandalf.local.home>
	<d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
	<20260703114233.56f0c864@gandalf.local.home>
	<360ba00d-352b-4fc1-9bfc-56d29b317f61@web.de>
	<20260703150933.3ce014b0@gandalf.local.home>
	<bc9627b8-90fe-42f4-82f1-541bd96866aa@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Stat-Signature: 1xcaje7dk7gaq4bdbj8din1jkt7e6kz6
X-Rspamd-Queue-Id: 8688820010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/G6G26Ry2MODlrR0SdrQbdg9TgW+9zV8I=
X-HE-Tag: 1783107215-563125
X-HE-Meta: U2FsdGVkX190o+FP7PD8jv9t7h4c5AXr+VJjXmMwreqGRODxRIonH0qw+GKO8JscIjzqcaysGB3mB+BsRIVGXGchR/SfaqufJhmmvYzkr7gsP1fdndmflRg5AdTdWBKgclkBDQ3lQ9CI5s+gWlSj/BfCfUg2TZf3Wym4BFmuZM19yWK7uUo6iJrxQif2Eb+rsrjWqmhFXOwG2zHjwNUrac4zdPr/N98278Y8zi+8bh8sPSU/mr/TYl7QDu8t0Ym6WR1GBXby82MEiiorP+TsnjY/L07KKh174hTG8Lkca66im/nyx1TxmOlibAluuv2/

On Fri, 3 Jul 2026 21:20:46 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > That example uses the variable in a specific block whereas this variable is
> > used in most of the function, which makes it appropriate where it lies.  
> 
> What does hinder you to apply scope reductions for selected local variables
> more often?
> 

OK, now you are just talking like Eliza.

-- Steve
