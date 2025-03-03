Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00271214A93;
	Mon,  3 Mar 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032181; cv=none; b=TlalvWoeC0H1h0xLrt7tZwtyak7SVP9YwihN2O5n7KYTwFgn2/ZxQ17SU4VzHlfoo9rS146MSVdFy7mJZX79nHCsfHMaoVQ6ETJ7sgRXBy5GV12wp+WbUCiylbMQ4nmcbqhtrV8EsTsxHd9gxsExoy8LfcakLO13zs/YqUOI/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032181; c=relaxed/simple;
	bh=73I1h4N8ONqM7LkCsAn6MUNbeUrw1eXTjVsd6IxZo0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpMcP4OA2iGkRxG6zml20fLZorWeK+LUAM2lMeZgy/0EWOfMdDvJdB8cHhJLTKiLesTlq8oV8PV+14xPGaryybElWDR0PF/T1rhutmlb64cQ1EpnGiYvaW6WMegvP+24NhrFEbB8ex5ip4a9SaPhv7UssJfO9OmxZqaKTB4SlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E85C4CEE5;
	Mon,  3 Mar 2025 20:02:59 +0000 (UTC)
Date: Mon, 3 Mar 2025 15:03:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian
 <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
Message-ID: <20250303150351.28007ad1@gandalf.local.home>
In-Reply-To: <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
References: <20250127170251.744751-1-costa.shul@redhat.com>
	<20250227200623.60f20571@gandalf.local.home>
	<CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 16:34:21 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> p=C3=A1 28. 2. 2025 v 2:05 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
> >
> > Without tracing being off, this can run forever if the events come in
> > faster than it can be recorded. And save trace uses the "trace" file, w=
hich
> > is slow to read.
> >
> > Are you sure you want that?
> > =20
>=20
> Isn't that a different problem though? As far as I'm aware, it
> shouldn't matter at all whether tracing is stopped on the main
> instance for collecting the trace from the record instance.
>=20
> If the record instance generates a lot of samples, this can already
> run forever, regardless of whether tracing is stopped on the main
> instance or not. This should be a separate fix.

Not sure what you mean by "main instance"?

The code being changed is:

-	if (osnoise_trace_is_off(tool, record)) {
+	if (osnoise_trace_is_off(tool, record))
 		printf("rtla osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+	if (params->trace_output) {
+		printf("  Saving trace to %s\n", params->trace_output);
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}

Where osnoise_trace_is_off() is:

bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *r=
ecord)
{
        /*
         * The tool instance is always present, it is the one used to colle=
ct
         * data.
         */
        if (!tracefs_trace_is_on(tool->trace.inst))
                return true;

        /*
         * The trace record instance is only enabled when -t is set. IOW, w=
hen the system
         * is tracing.
         */
        return record && !tracefs_trace_is_on(record->trace.inst);
}


Which returns true if the tool->trace.inst is on and false otherwise.

-- Steve
