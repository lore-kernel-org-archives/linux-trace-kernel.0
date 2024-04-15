Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6E241E1;
	Mon, 15 Apr 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170675; cv=none; b=j5d1IK861s/yE/GcI5BhdTGjtLCuYssCoWBl3V0oaWwZ6ZoYC7ZhLekYzhITF2q46vCXdu6RqY1uy0C/p6lL5xcnvLUCSy1tCPdYkKhwEeIAfBHMZ4G7ytuD9ekNX3t9Zj55rBb9MbSCiTLcinKWK0pB9DtygjzOmHMrlb4LkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170675; c=relaxed/simple;
	bh=DBBTnXISGqvnEtKSDNsrMZDg6GcbyuEhLTHRaOSoMII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=befL5WANmAjg1fLLu0YaSEuN6RuSgYJ+TiaO6J4r7JfPRJCEdl1I7TYrw+0fH3jRYXjPYNusWwagwtkf4UoxAi3pl5eQIh+y+2IiCuu6krlHF/mFa2n/jng2LCs6IfpoTBYcxpPgjvDGbHtUrKduT6xHnPuV9DMmMyFMSg1kgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D34C113CC;
	Mon, 15 Apr 2024 08:44:34 +0000 (UTC)
Date: Mon, 15 Apr 2024 04:44:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240415044431.308f2e09@rorschach.local.home>
In-Reply-To: <20240318164307.53c5595f@booty>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
	<20240318164307.53c5595f@booty>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 16:43:07 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> However the arrows are still reversed.

This requires a kernel change. The problem is that the print fmt has:

print fmt: "%c%s %s %s %s %s", (int) REC->path_node && (int) REC->path_connect ? '*' : ' ', __get_str(wname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pnname)

User space (trace-cmd and perf) have no idea what SND_SOC_DAPM_DIR_OUT
is. The kernel needs to convert that, otherwise the parsing will fail,
or it will default it to zero.

-- Steve
