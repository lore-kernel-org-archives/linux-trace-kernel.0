Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3C310768;
	Wed,  4 Feb 2026 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243848; cv=none; b=DKZDsRu2ifisHdpZoiV2EJBM1hsolbMFwXlWrZolKK9EhAD1gXhKEX9jOiKS5LJT1AbxrAsmK5JE0rk9R/E0UTpDVs5fHAvSKpLkYEhyxB8bCqhNkCPmhUPof/vp4TnQykS9peJ07uXsoyVyx2emVIjyaxZa6/tLuqAD5yy4TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243848; c=relaxed/simple;
	bh=3wNZC9RKVA/M7aXVumChTL3fjfnouDVLUsyOZjqTEvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uob/4PKFQqfOfshGX1p8VsSxrq12Rl1mOmE3tUQMnKLA8A8C7FXR9e1Q1oXoL/1K323WKsTZH0qsUJuBsaR6eIUs8hLmVgfmT0b0pCFkl/7bCrFmIsODa08GW0bMh8tN+GNVxj0HUPDyQelV7NQLZU1NyNRZhErzZG18aQQwL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C5DE213A7C4;
	Wed,  4 Feb 2026 22:24:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 303EF20025;
	Wed,  4 Feb 2026 22:24:05 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:24:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Julius Werner <jwerner@google.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] bootconfig: Check the parsed output of the good
 examples
Message-ID: <20260204172437.78885c0a@gandalf.local.home>
In-Reply-To: <177019403805.80694.10065992068449824435.stgit@devnote2>
References: <177019401833.80694.554894321526842218.stgit@devnote2>
	<177019403805.80694.10065992068449824435.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 303EF20025
X-Stat-Signature: emtckpk98xuzys1chke4qrfaewzwepha
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fFWjqXYmrpQzsdjwOtt3kSLJcNRk15Sc=
X-HE-Tag: 1770243845-542135
X-HE-Meta: U2FsdGVkX19SFCEKt6lA3zktbXgvr9g8PkRzvq4I+owV31ToYv2o4Y06mNttTnAY8ot0MQ/m6VT2KAyaewbm61eHAB3nWmwp0TvR+SGAfcvNvHx9IWWaTsr4QvKbK/6aTRFeTCkvk2Y7Zmv+Tohfiu+7KsDkYNBogbe51QOZNfBQm/WplTZPtp/uIFQIWO1psncZnDVq+rt17GGb31T2dmbl2K3a85eWvW+wO0CHEft5fx1PqjNuZ6xfMu3CacSh6OSVCZZwBDtG5Cg4qgAlF+Tte6/euCw4MYWwOxO2FVbD25rSarEFo+f4vv5IOXOeucSLkiT+0cfevmVKXames61ez6VaLl2fuSWuLdlTUupyIWtYnr2tbj49OMWFcPyR5mqlu0N13OA30zqh5fG43A==

On Wed,  4 Feb 2026 17:33:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check whether the parsed output of the good example configs are
> the same as expected.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
