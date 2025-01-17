Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3E1FCFFC;
	Fri, 17 Jan 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111574; cv=none; b=tGvGvDgOqyzT5VOw+jAEz/JQG52K3C1hu0pK/uyE5JPJTIafkx7Rkea5xxYBJK5u7keCDMzuy/SucDQFlP8ANEG3Wqg2Ba9UEwjCNfstsITl2NnVcnO0I38ezDfK51zD73SHXbSGqw1vWFOl8ZGc4eXxwqe+GE7q5roTKL+JlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111574; c=relaxed/simple;
	bh=5rcqUWTA49JcolMLO7/2o6YDvGwRODlNqAJ4RqyRbSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJcQL4JT3XZ5O92qavGKqiFPZRSDWNXi+vo05HduYakZd1a9CRVx9RdTGfIfa5X9V2ppMGnqMCT9w2rx0TSBKPaK2KxdSGl9i3Zy7D0MSNf/FkTUfmvIXfQpRDrwnsvsrUhJaGKC8dBltONngzQ2zi4bVjO/1EDKkY7L1emCUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9BBC4CEDD;
	Fri, 17 Jan 2025 10:59:33 +0000 (UTC)
Date: Fri, 17 Jan 2025 05:59:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin
 <cyin@redhat.com>, Qiao Zhao <qzhao@redhat.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
Message-ID: <20250117055940.59dcc01d@gandalf.local.home>
In-Reply-To: <CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
References: <20250109133852.360122-1-tglozar@redhat.com>
	<20250116201808.3c8721c1@gandalf.local.home>
	<CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:53:48 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Maybe after enough time repeating the command I'm also going to hit
> the bug you saw.

Note, I am running it on a VM, not necessarily the best place to run an RT app.

Also, I'm in my BRANCH PROFILING phase, where my machines have the
#define if enabled, and is running about 1/5th the normal speed.

Thus, it will trigger large latency and delays.

-- Steve
