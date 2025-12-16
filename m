Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94533D6D9;
	Tue, 16 Dec 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908193; cv=none; b=JU+Gsh9QSwMtgRoICoi09z+R5H9SWtTy9w0wx7xDDi5BqS7CSGx6wGztZgkQ2cn5ZE7/quwnYwVbA57NTDOzBRcOB9mwIf6ejIQ6B66ic9kQ+KxgctV4ytMzlaB1rVC/cF4tluV3qI/e/M4UCR3jtRhfR/ZGdofD+7muaQ57bPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908193; c=relaxed/simple;
	bh=ZwfuxM7U6ZwzjULA9qu6yDWssHfVK+v30Muvr43/itg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EW1uP27Q1vr+TpPbZXfP0aQfQqd4doyr/6rDKLCEbfvh0YdiMIhSq/x3IaK6Z+eAzfJt0StVgbhM4ua4QJWOprlxm6vL91OZSCwTYgHNsVkZCwPK6a1l62HtgbrJE1+AZYddipiwfZtNVf7ERbS9MMdfgJtf+JPR2PflnVEUUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6B9F2131FB;
	Tue, 16 Dec 2025 18:03:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 636BC20026;
	Tue, 16 Dec 2025 18:03:06 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:04:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] tools/rtla: Consolidate -C/--cgroup option
 parsing
Message-ID: <20251216130440.19d86b69@gandalf.local.home>
In-Reply-To: <tazkdgebtw7sgrw7cjrntde6hpcqqlbg7spllkquqxsqowj2uo@xegmfpfkgps7>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
	<20251209100047.2692515-3-costa.shul@redhat.com>
	<tazkdgebtw7sgrw7cjrntde6hpcqqlbg7spllkquqxsqowj2uo@xegmfpfkgps7>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 636BC20026
X-Stat-Signature: mituo8w3adz7hks64j8o5ah9atpk3zqb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19smr1906Z1S1ohk8RytfBQCwgKVpSWzyg=
X-HE-Tag: 1765908186-198999
X-HE-Meta: U2FsdGVkX1/7urrP4cakOlOgQHeNxEaS0ErxtAC3taQc/KFyZFGe7JicSZaX1qm0UBX6wAIa2kxgOhPkSlILSxkcct/wNzTGHM/K0YtzK5QH2CI/5vBHVf66Ylq3EFPU++Vl12BZrscuBONMURw1OldRj7f8Ey8hR+aTYq4R3fwrjGbj1vH2ZiUO9XGQ2CfaS0srHxbTxJGOy6LxLRdQm7TENWfqBKqdg8U2vKlS1CMUEvtZ261Y0dYAk2RUnOd4LTRryX4TZVVR3GrFoLzeAEUOGAe53O6df9Yaw4zeQWxGGiAbtIJYz+ho4JsjOkJtX/ez6qNc5HrtxMdvwFBi6fyNnk6qjB1MaOU1lbojmvBkgzxDsItFMw==

On Tue, 16 Dec 2025 13:17:00 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> >  			break;
> > -- 
> > 2.52.0
> >   
> 
> Reviewed-by: Wander Lairson Costa <wander@redhat.com>

Please trim your replies. It's very annoying to scroll down several pages
just to find a reviewed-by tag.

-- Steve
