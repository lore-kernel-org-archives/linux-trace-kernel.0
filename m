Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467A1CDFC2;
	Thu, 10 Oct 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589007; cv=none; b=HEFZhJR67bdZ/mrb4xGSXuFym2HbCEyWylJZMiwDhv98uVjBYQDJhrT7Z//EW5umsZD+/7Lz9IqO6PxAMfpAzq9em0yEs5r3hB51DIWFprhI+jpDqNj4YNsx6v1a+DuN7ILC+xiNK/+4t8DiUKsLDQS+no5W/4LGEXI6gXzXMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589007; c=relaxed/simple;
	bh=b4Gn6K1zM9UemvOcVv6txpN/hVPaGddDTXIy08SV/7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ3jXmIVGVTSZsuOIWv/rSD8zQ3Z4HW7UWuhiiwSSm5Ef2VcjlyNMlsDL/71EXx8ER2cMFSnikqariXOvGP7BqhRf2sU7/dcuxRk9JY27X5UsoDQ9pFv1IWQj18f6NIpZA6U6A1umshNfgzlc7VzyRGOSSSQlcp3vamrXJW0QxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3742C4CEC5;
	Thu, 10 Oct 2024 19:36:45 +0000 (UTC)
Date: Thu, 10 Oct 2024 15:36:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 21/35] ring-buffer: Reorganize kerneldoc parameter names
Message-ID: <20241010153653.1809bca9@gandalf.local.home>
In-Reply-To: <20240930111431.258b72d1@gandalf.local.home>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
	<20240930112121.95324-22-Julia.Lawall@inria.fr>
	<20240930111431.258b72d1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 11:14:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Sep 2024 13:21:07 +0200
> Julia Lawall <Julia.Lawall@inria.fr> wrote:
> 
> > Reorganize kerneldoc parameter names to match the parameter
> > order in the function header.
> > 
> > Problems identified using Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>  
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This is part of a series, but do you want me to take it through my tree, or
is this going though another tree?

-- Steve
